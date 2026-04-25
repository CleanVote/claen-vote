import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/project_model.dart';
import '../services/auth_service.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;
  final AuthService authService;

  const ProjectDetailsScreen({super.key, required this.project, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0, scrolledUnderElevation: 2,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Loyiha tafsilotlari', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
        actions: [IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {})],
      ),
      body: ListenableBuilder(
        listenable: authService,
        builder: (context, _) {
          final user = authService.currentUser!;
          final isInMahalla = project.belongsToMahalla(user.mahalla);
          final canVote = isInMahalla && !user.hasVoted;
          final isVoted = user.votedProjectId == project.id;

          return ListView(
            padding: const EdgeInsets.only(bottom: 120),
            children: [
              // Hero image
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primaryContainer, AppColors.primary.withValues(alpha: 0.7)]),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 4))],
                  ),
                  child: Stack(
                    children: [
                      Center(child: Icon(
                        project.category.contains("Yo'l") ? Icons.add_road : project.category.contains("Ta'lim") ? Icons.school : project.category.contains('Ichimlik') ? Icons.water_drop : project.category.contains('Infra') ? Icons.domain : Icons.park,
                        size: 64, color: Colors.white.withValues(alpha: 0.6),
                      )),
                      if (isInMahalla)
                        Positioned(top: 12, left: 12, child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(100)),
                          child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.check_circle, size: 16, color: Colors.white), SizedBox(width: 6), Text('Sizning mahallangizga mos', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))]),
                        )),
                    ],
                  ),
                ),
              ),
              // Title & meta
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(project.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.24, color: AppColors.onSurface)),
                  const SizedBox(height: 8),
                  Row(children: [const Icon(Icons.location_on_outlined, size: 18, color: AppColors.onSurfaceVariant), const SizedBox(width: 4), Expanded(child: Text(project.location, style: const TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant)))]),
                  const SizedBox(height: 6),
                  Row(children: [const Icon(Icons.payments_outlined, size: 18, color: AppColors.onSurfaceVariant), const SizedBox(width: 4), Text(project.budgetFormatted, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)), const SizedBox(width: 4), const Text('so\'ralgan summa', style: TextStyle(fontSize: 14, color: AppColors.outline))]),
                ]),
              ),
              // Hidden votes
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.outlineVariant)),
                  child: const Row(children: [Icon(Icons.visibility_off_outlined, size: 20, color: AppColors.outline), SizedBox(width: 12), Expanded(child: Text('Ovozlar soni yakuniy bosqichda e\'lon qilinadi.', style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant)))]),
                ),
              ),
              // Description
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Loyiha tavsifi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  const SizedBox(height: 8),
                  Text(project.description, style: const TextStyle(fontSize: 16, height: 1.5, color: AppColors.onSurfaceVariant)),
                ]),
              ),
              // Vote action
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                child: Column(children: [
                  const Divider(color: AppColors.outlineVariant),
                  const SizedBox(height: 16),
                  if (!isInMahalla) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppColors.errorContainer, borderRadius: BorderRadius.circular(8)),
                      child: const Row(children: [Icon(Icons.warning, size: 18, color: AppColors.onErrorContainer), SizedBox(width: 8), Expanded(child: Text('Faqat o\'z mahallangizdagi loyihalarga ovoz bera olasiz', style: TextStyle(fontSize: 14, color: AppColors.onErrorContainer)))]),
                    ),
                    const SizedBox(height: 12),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: canVote ? () => _vote(context) : null,
                      icon: Icon(isVoted ? Icons.check_circle : Icons.how_to_vote, size: 20),
                      label: Text(isVoted ? 'Ovoz berildi ✓' : !isInMahalla ? 'Ovoz berish' : user.hasVoted ? 'Ovoz berilgan' : 'Ovoz berish'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isVoted ? AppColors.secondaryContainer : canVote ? AppColors.secondary : AppColors.surfaceVariant,
                        foregroundColor: isVoted ? AppColors.secondary : canVote ? AppColors.onSecondary : AppColors.outline,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (isInMahalla) const Text('Siz sezonda faqat 1 ta loyihaga ovoz bera olasiz.', style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant), textAlign: TextAlign.center),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  void _vote(BuildContext context) {
    HapticFeedback.heavyImpact();
    authService.voteForProject(project.id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [Icon(Icons.check_circle, color: Colors.white), SizedBox(width: 8), Text('Ovozingiz qabul qilindi!', style: TextStyle(fontWeight: FontWeight.w600))]),
      backgroundColor: AppColors.secondary, behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
    Navigator.pop(context);
  }
}
