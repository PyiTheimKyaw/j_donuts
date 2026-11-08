import 'package:equatable/equatable.dart';
import 'package:j_donuts/features/home/domain/entities/image_ref.dart';

/// Picks the progress painter: a donut coloured in by quarters or a coffee
/// arc that fills.
enum ChallengeArtwork { donut, coffee }

enum ChallengeTab { earn, gift }

final class Challenge extends Equatable {
  const Challenge({
    required this.id,
    required this.title,
    required this.artwork,
    required this.image,
    required this.progress,
    required this.goal,
    required this.rewardPoints,
    required this.tab,
  });

  final String id;
  final String title;
  final ChallengeArtwork artwork;
  final ImageRef image;
  final int progress;
  final int goal;
  final int rewardPoints;
  final ChallengeTab tab;

  bool get isComplete => progress >= goal;

  double get fraction => goal == 0 ? 0 : (progress / goal).clamp(0, 1);

  @override
  List<Object?> get props => [
    id,
    title,
    artwork,
    image,
    progress,
    goal,
    rewardPoints,
    tab,
  ];
}
