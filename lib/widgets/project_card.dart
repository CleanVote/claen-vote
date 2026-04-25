import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/project_model.dart';

/// Project Card widget matching the design spec:
/// - White background, Level 1 shadow, 16px rounded corners
/// - 4px green accent bar on left for active/in-mahalla projects
/// - Hidden vote count indicator
/// - Category chip + location
class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isInMahalla;
  final bool hasVoted;
  final String? votedProjectId;
  final VoidCallback? onVote;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.isInMahalla,
    this.hasVoted = false,
    this.votedProjectId,
    this.onVote,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isVotedProject = votedProjectId == project.id;
    final bool canVote = isInMahalla && !hasVoted;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isInMahalla
              ? AppColors.surfaceContainerLowest
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isVotedProject
                ? AppColors.secondary.withValues(alpha: 0.5)
                : AppColors.outlineVariant.withValues(alpha: isInMahalla ? 0.2 : 0.4),
            width: isVotedProject ? 2 : 1,
          ),
          boxShadow: isInMahalla
              ? [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.cardShadow.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Stack(
          children: [
            // Green accent bar for in-mahalla projects
            if (isInMahalla)
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
              ),

            Padding(
              padding: EdgeInsets.only(
                left: isInMahalla ? 20 : 16,
                right: 16,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: Category chip + Vote status
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      // Category chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isInMahalla
                              ? AppColors.secondaryContainer
                              : AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          project.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            color: isInMahalla
                                ? AppColors.onSecondaryContainer
                                : AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),

                      // Vote hidden indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.visibility_off_outlined,
                              size: 14,
                              color: AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isInMahalla
                                  ? 'Ovozlar yashirilgan'
                                  : 'Yashirilgan',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Project title
                  Text(
                    project.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 28 / 20,
                      color: isInMahalla
                          ? AppColors.onSurface
                          : AppColors.outline,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Location
                  if (isInMahalla)
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            project.location,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    // "Boshqa mahalla" warning
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.errorContainer.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.block, size: 16, color: AppColors.error),
                          const SizedBox(width: 4),
                          Text(
                            'Boshqa mahalla loyihasi',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Divider
                  Divider(color: isInMahalla
                      ? AppColors.surfaceVariant
                      : AppColors.outlineVariant.withValues(alpha: 0.3)),

                  const SizedBox(height: 12),

                  // Budget + Vote button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'So\'ralgan summa:',
                            style: TextStyle(
                              fontSize: 14,
                              color: isInMahalla
                                  ? AppColors.onSurfaceVariant
                                  : AppColors.outline,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            project.budgetFormatted,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isInMahalla
                                  ? AppColors.onSurface
                                  : AppColors.outline,
                            ),
                          ),
                        ],
                      ),

                      // Vote button
                      if (isInMahalla)
                        _buildVoteButton(canVote, isVotedProject)
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.outlineVariant.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            'Boshqa mahalla',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.outline,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoteButton(bool canVote, bool isVotedProject) {
    if (isVotedProject) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 20, color: AppColors.secondary),
            const SizedBox(width: 8),
            Text(
              'Ovoz berildi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      );
    }

    return Material(
      color: canVote ? AppColors.primary : AppColors.surfaceVariant,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: canVote ? onVote : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: canVote
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.how_to_vote,
                size: 20,
                color: canVote ? AppColors.onPrimary : AppColors.outline,
              ),
              const SizedBox(width: 8),
              Text(
                hasVoted ? 'Ovoz berilgan' : 'Ovoz berish',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: canVote ? AppColors.onPrimary : AppColors.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
