import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/project_model.dart';
import '../services/auth_service.dart';
import '../widgets/project_card.dart';
import 'project_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final AuthService authService;
  const HomeScreen({super.key, required this.authService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ProjectModel> _allProjects = ProjectModel.demoProjects();

  @override
  Widget build(BuildContext context) {
    final user = widget.authService.currentUser!;
    final userMahalla = user.mahalla;
    final myProjects = _allProjects.where((p) => p.belongsToMahalla(userMahalla)).toList();
    final otherProjects = _allProjects.where((p) => !p.belongsToMahalla(userMahalla)).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0,
        scrolledUnderElevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          user.mahalla.replaceAll(' mahallasi', ' Mahalla'),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surfaceVariant,
              child: const Icon(Icons.person, size: 20, color: AppColors.outline),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.authService,
        builder: (context, _) {
          final currentUser = widget.authService.currentUser!;
          return ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              // Context header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.region}, ${user.district}'.toUpperCase(),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: AppColors.outline),
                    ),
                    const SizedBox(height: 4),
                    Text(user.mahalla, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: -0.6, color: AppColors.onSurface)),
                  ],
                ),
              ),
              // Info banner
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, size: 20, color: AppColors.secondary),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Siz faqat o\'zingiz ro\'yxatdan o\'tgan hudud loyihalariga ovoz bera olasiz. Boshqa mahallalar loyihalari yopiq.',
                          style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // My mahalla projects
              ...myProjects.map((project) => Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: ProjectCard(
                  project: project, isInMahalla: true,
                  hasVoted: currentUser.hasVoted, votedProjectId: currentUser.votedProjectId,
                  onVote: () => _handleVote(project),
                  onTap: () => _openDetails(project),
                ),
              )),
              // Other mahalla projects
              ...otherProjects.map((project) => Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: ProjectCard(
                  project: project, isInMahalla: false,
                  onTap: () => _openDetails(project),
                ),
              )),
            ],
          );
        },
      ),
    );
  }

  void _handleVote(ProjectModel project) {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Ovoz berish'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Quyidagi loyihaga ovoz berishni tasdiqlaysizmi?'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.surfaceContainer, borderRadius: BorderRadius.circular(8)),
              child: Text(project.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.errorContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(8)),
              child: const Row(children: [
                Icon(Icons.warning_amber, size: 18, color: AppColors.error),
                SizedBox(width: 8),
                Expanded(child: Text('Diqqat! Siz sezonda faqat 1 ta loyihaga ovoz bera olasiz.', style: TextStyle(fontSize: 13, color: AppColors.error, fontWeight: FontWeight.w500))),
              ]),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Bekor qilish', style: TextStyle(color: AppColors.outline))),
          ElevatedButton.icon(
            onPressed: () {
              widget.authService.voteForProject(project.id);
              Navigator.pop(ctx);
              _showSuccess();
            },
            icon: const Icon(Icons.how_to_vote, size: 18),
            label: const Text('Ovoz berish'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary, foregroundColor: AppColors.onSecondary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
        ],
      ),
    );
  }

  void _showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [Icon(Icons.check_circle, color: Colors.white, size: 20), SizedBox(width: 8), Expanded(child: Text('Ovozingiz muvaffaqiyatli qabul qilindi!', style: TextStyle(fontWeight: FontWeight.w600)))]),
      backgroundColor: AppColors.secondary, behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 80),
    ));
  }

  void _openDetails(ProjectModel project) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProjectDetailsScreen(project: project, authService: widget.authService)));
  }
}
