import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/formatting/number_format.dart';
import 'package:j_donuts/core/widgets/app_image.dart';
import 'package:j_donuts/core/widgets/skeleton.dart';
import 'package:j_donuts/features/home/domain/entities/member.dart';
import 'package:j_donuts/features/home/presentation/home_labels.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class MemberHeader extends StatelessWidget {
  const MemberHeader({
    required this.member,
    required this.displayName,
    required this.onNotificationsTap,
    super.key,
  });

  final Member member;
  final String displayName;
  final VoidCallback onNotificationsTap;

  static const double avatarSize = 56;
  static const double _avatarRing = 3;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final nextTier = member.nextTier;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IdentityRow(
            member: member,
            displayName: displayName,
            onNotificationsTap: onNotificationsTap,
          ),
          if (nextTier != null) ...[
            const SizedBox(height: AppSpacing.md),
            _PointsChip(
              text: l10n.pointsToNextTier(
                formatGrouped(member.pointsToNextTier, locale: locale),
                nextTier.label(l10n),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IdentityRow extends StatelessWidget {
  const _IdentityRow({
    required this.member,
    required this.displayName,
    required this.onNotificationsTap,
  });

  final Member member;
  final String displayName;
  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Avatar(member: member),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _NameAndTier(member: member, displayName: displayName),
        ),
        _NotificationBell(
          count: member.notificationCount,
          onTap: onNotificationsTap,
        ),
      ],
    );
  }
}

class _NameAndTier extends StatelessWidget {
  const _NameAndTier({required this.member, required this.displayName});

  final Member member;
  final String displayName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayName,
          style: AppTypography.headline,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          l10n.memberTier(member.tier.label(l10n)),
          style: AppTypography.bodySmall.copyWith(color: AppColors.ink),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MemberHeader._avatarRing),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.warning,
      ),
      child: ClipOval(
        child: AppImage(
          member.photo,
          width: MemberHeader.avatarSize,
          height: MemberHeader.avatarSize,
        ),
      ),
    );
  }
}

class _PointsChip extends StatelessWidget {
  const _PointsChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        text,
        style: AppTypography.caption.copyWith(color: AppColors.ink),
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  static const EdgeInsets _padding = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.sm,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Semantics(
      button: true,
      label: l10n.unreadNotifications(count),
      excludeSemantics: true,
      child: Material(
        color: AppColors.warning,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: Padding(
            padding: _padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.onPrimary,
                ),
                if (count > 0) ...[
                  const SizedBox(width: AppSpacing.xs),
                  _UnreadBadge(count: count),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  static const double _size = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$count',
        style: AppTypography.caption.copyWith(
          color: AppColors.warning,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class MemberHeaderSkeleton extends StatelessWidget {
  const MemberHeaderSkeleton({super.key});

  static const double _nameWidth = 140;
  static const double _lineHeight = 16;
  static const double _nameLineHeight = _lineHeight * 1.5;
  static const double _chipWidth = 220;
  static const double _chipHeight = 24;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Skeleton.circle(size: MemberHeader.avatarSize),
              SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(width: _nameWidth, height: _nameLineHeight),
                  SizedBox(height: AppSpacing.sm),
                  Skeleton(width: _nameWidth / 2, height: _lineHeight),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Skeleton(width: _chipWidth, height: _chipHeight),
        ],
      ),
    );
  }
}
