import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';
import 'package:j_donuts/core/widgets/entrance_animation.dart';
import 'package:j_donuts/features/auth/presentation/widgets/auth_scaffold.dart';

/// Every registration step is a headline, its fields and a Continue button,
/// entering in that order. Numbering the stagger here keeps the rhythm the
/// same on every step instead of hand-counting indices per screen.
class AuthStepForm extends StatelessWidget {
  const AuthStepForm({
    required this.step,
    required this.title,
    required this.fields,
    required this.continueButton,
    super.key,
  });

  final int step;
  final String title;
  final List<Widget> fields;
  final Widget continueButton;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      step: step,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EntranceAnimation(child: Text(title, style: AppTypography.headline)),
          const SizedBox(height: AppSpacing.xxl),
          for (final (index, field) in fields.indexed) ...[
            if (index > 0) const SizedBox(height: AppSpacing.lg),
            EntranceAnimation(index: index + 1, child: field),
          ],
        ],
      ),
      bottom: EntranceAnimation(
        index: fields.length + 1,
        child: continueButton,
      ),
    );
  }
}
