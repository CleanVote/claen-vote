import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/auth_service.dart';

class MyVotesScreen extends StatelessWidget {
  final AuthService authService;
  const MyVotesScreen({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.surfaceContainerLowest, elevation: 0, centerTitle: true, title: const Text('Mening ovozlarim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary))),
      body: ListenableBuilder(
        listenable: authService,
        builder: (context, _) {
          final user = authService.currentUser!;
          if (!user.hasVoted) {
            return Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 80, height: 80, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.surfaceContainer), child: const Icon(Icons.how_to_vote_outlined, size: 40, color: AppColors.outline)),
              const SizedBox(height: 24),
              const Text('Hali ovoz berilmagan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text('Loyihalar bo\'limiga o\'ting va o\'z mahallangizga mos loyihaga ovoz bering.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant)),
            ])));
          }
          return ListView(padding: const EdgeInsets.all(20), children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.secondaryContainer.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3))),
              child: const Column(children: [Icon(Icons.check_circle, size: 48, color: AppColors.secondary), SizedBox(height: 12), Text('Ovozingiz qabul qilindi!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)), SizedBox(height: 4), Text('Ovozingiz xavfsiz tarzda saqlandi', style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant))]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 4))]),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [Icon(Icons.how_to_vote, size: 20, color: AppColors.primary), SizedBox(width: 8), Text('Ovoz berilgan loyiha', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: AppColors.primary))]),
                const SizedBox(height: 12),
                Text('Loyiha ID: ${user.votedProjectId}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16), const Divider(color: AppColors.outlineVariant), const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.outlineVariant)),
                  child: const Row(children: [Icon(Icons.visibility_off_outlined, size: 18, color: AppColors.outline), SizedBox(width: 8), Expanded(child: Text('Ovozlar soni yakuniy bosqichda e\'lon qilinadi', style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant)))]),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.primaryContainer.withValues(alpha: 0.1), borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)), border: const Border(left: BorderSide(color: AppColors.primary, width: 4))),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Ovoz berish qoidalari', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                SizedBox(height: 8),
                Text('• Har bir fuqaro sezonda faqat 1 ta loyihaga ovoz bera oladi\n• Ovozlar soni yakunigacha yashirinadi\n• Ovozlar faqat propiska bo\'yicha beriladi\n• Natijalar yakuniy sanada e\'lon qilinadi', style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.onSurface)),
              ]),
            ),
          ]);
        },
      ),
    );
  }
}
