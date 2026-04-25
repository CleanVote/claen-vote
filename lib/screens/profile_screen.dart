import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService authService;
  final VoidCallback onLogout;
  const ProfileScreen({super.key, required this.authService, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final user = authService.currentUser!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.surfaceContainerLowest, elevation: 0, centerTitle: true, title: const Text('Profil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
        children: [
          Center(child: Column(children: [
            Container(width: 80, height: 80, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryFixed), child: const Icon(Icons.person, size: 40, color: AppColors.primary)),
            const SizedBox(height: 16),
            Text(user.fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.secondaryContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(100)), child: const Text('OneID tasdiqlangan ✓', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.secondary))),
          ])),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.surfaceContainerLowest, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 4))]),
            child: Column(children: [
              _InfoRow(icon: Icons.badge_outlined, label: 'PINFL', value: _mask(user.pinfl)),
              const Divider(height: 24), _InfoRow(icon: Icons.phone_outlined, label: 'Telefon', value: user.phoneNumber),
              const Divider(height: 24), _InfoRow(icon: Icons.map_outlined, label: 'Viloyat', value: user.region),
              const Divider(height: 24), _InfoRow(icon: Icons.location_city_outlined, label: 'Tuman', value: user.district),
              const Divider(height: 24), _InfoRow(icon: Icons.home_outlined, label: 'Mahalla', value: user.mahalla),
              const Divider(height: 24), _InfoRow(icon: Icons.place_outlined, label: 'Manzil', value: user.address),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.primaryContainer.withValues(alpha: 0.1), borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)), border: const Border(left: BorderSide(color: AppColors.primary, width: 4))),
            child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.info_outline, size: 20, color: AppColors.primary), SizedBox(width: 12), Expanded(child: Text('Mahallangiz OneID asosida avtomatik aniqlangan.', style: TextStyle(fontSize: 14, color: AppColors.onSurface)))]),
          ),
          const SizedBox(height: 32),
          SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: onLogout, icon: const Icon(Icons.logout, size: 18), label: const Text('Tizimdan chiqish'), style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))))),
        ],
      ),
    );
  }

  String _mask(String p) => p.length < 6 ? p : '${p.substring(0, 3)}${'*' * (p.length - 6)}${p.substring(p.length - 3)}';
}

class _InfoRow extends StatelessWidget {
  final IconData icon; final String label; final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 20, color: AppColors.primary), const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: AppColors.outline)),
      const SizedBox(height: 2),
      Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
    ])),
  ]);
}
