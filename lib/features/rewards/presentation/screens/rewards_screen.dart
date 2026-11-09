import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/core/widgets/skeleton.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/home/presentation/home_view_models.dart';
import 'package:j_donuts/features/home/presentation/widgets/section_state.dart';
import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';
import 'package:j_donuts/features/rewards/presentation/rewards_view_models.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/challenge_card.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/points_ring.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/reward_tabs.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/rewards_badge.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/tier_ladder_view.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

/// Reads the same member record as Home, so tier and points can never differ
/// between the two tabs.
class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(currentMemberProvider);
    final bottomClearance =
        MediaQuery.paddingOf(context).bottom + AppSpacing.xl;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SectionState<Member?>(
              value: member,
              isEmpty: (value) => value == null,
              onRetry: () => ref.invalidate(currentMemberProvider),
              skeleton: const _HeaderSkeleton(),
              builder: (value) => _Header(member: value!),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.lg,
              AppSpacing.gutter,
              0,
            ),
            sliver: SliverToBoxAdapter(child: _ChallengeList()),
          ),
          SliverToBoxAdapter(child: SizedBox(height: bottomClearance)),
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.member});

  final Member member;

  /// The ring is wider than its column and runs off the right edge.
  static const double _ringWidthFraction = 0.6;
  static const double _ringBleedFraction = 0.2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final ringDiameter = width * _ringWidthFraction;
    final ringLeft = width - ringDiameter * (1 - _ringBleedFraction);
    final ladderWidth = ringLeft - AppSpacing.gutter - AppSpacing.sm;
    final selectedTab = ref.watch(selectedRewardTabProvider);

    return Stack(
      children: [
        const Positioned.fill(
          bottom: RewardTabs.height / 2,
          child: ColoredBox(color: AppColors.surface),
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.gutter,
                        right: AppSpacing.md,
                      ),
                      child: EntranceAnimation(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            l10n.rewardsTitle,
                            maxLines: 1,
                            style: AppTypography.headline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  RewardsBadge(count: member.rewardCount),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                height: ringDiameter,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: AppSpacing.gutter,
                      top: AppSpacing.sm,
                      width: ladderWidth,
                      child: TierLadderView(member: member),
                    ),
                    Positioned(
                      right: -ringDiameter * _ringBleedFraction,
                      top: 0,
                      child: EntranceAnimation(
                        index: 1,
                        gap: AppDurations.sectionStaggerGap,
                        beginScale: AppMotionScales.popFrom + 0.4,
                        offset: Offset.zero,
                        child: PointsRing(
                          progress: member.tierProgress,
                          totalPoints: member.totalPoints,
                          diameter: ringDiameter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              RewardTabs(
                selected: selectedTab,
                onSelected: (tab) =>
                    ref.read(selectedRewardTabProvider.notifier).selected = tab,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChallengeList extends ConsumerWidget {
  const _ChallengeList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challenges = ref.watch(rewardChallengesProvider);
    final tab = ref.watch(selectedRewardTabProvider);

    return SectionState<List<Challenge>>(
      value: challenges.whenData(
        (all) => all.where((c) => c.tab == tab).toList(),
      ),
      isEmpty: (value) => value.isEmpty,
      onRetry: () => ref.invalidate(rewardChallengesProvider),
      skeleton: const _CardsSkeleton(),
      builder: (visible) => AnimatedSwitcher(
        duration: AppMotion.scaled(context, AppDurations.medium),
        switchInCurve: AppCurves.standard,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0.06, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: Column(
          key: ValueKey(tab),
          children: [
            for (final (index, challenge) in visible.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: EntranceAnimation(
                  index: index,
                  gap: AppDurations.sectionStaggerGap,
                  child: ChallengeCard(challenge: challenge),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSkeleton extends StatelessWidget {
  const _HeaderSkeleton();

  static const double _height = 420;

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.surface,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: Skeleton(height: _height, radius: AppRadii.xl),
        ),
      ),
    );
  }
}

class _CardsSkeleton extends StatelessWidget {
  const _CardsSkeleton();

  static const double _cardHeight = 150;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Skeleton(height: _cardHeight, radius: AppRadii.xl),
        SizedBox(height: AppSpacing.lg),
        Skeleton(height: _cardHeight, radius: AppRadii.xl),
      ],
    );
  }
}
