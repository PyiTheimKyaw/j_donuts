import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/features/rewards/domain/entities/challenge.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/challenge_art.dart';
import 'package:j_donuts/features/rewards/presentation/widgets/earn_button.dart';
import 'package:j_donuts/l10n/generated/app_localizations.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({required this.challenge, super.key});

  final Challenge challenge;

  static const double artSize = 120;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Row(
        children: [
          ChallengeArt(challenge: challenge, size: artSize),
          const SizedBox(width: AppSpacing.lg),
          Expanded(child: _ChallengeDetails(challenge: challenge)),
        ],
      ),
    );
  }
}

class _ChallengeDetails extends StatelessWidget {
  const _ChallengeDetails({required this.challenge});

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(challenge.title, style: AppTypography.title),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.challengeProgress(challenge.progress, challenge.goal),
          style: AppTypography.body,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            EarnButton(isActive: challenge.isComplete),
            const SizedBox(width: AppSpacing.lg),
            Flexible(
              child: Text(
                l10n.pointsReward(challenge.rewardPoints),
                style: AppTypography.body,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
