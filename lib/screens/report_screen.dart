import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

/// Anonim shikoyat yuborish (Anonymous Complaint) screen
/// Encrypted, no IP/device tracking, fully anonymous
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _selectedTopic;
  final _descController = TextEditingController();
  bool _isSending = false;
  bool _sent = false;

  final _topics = [
    'Infratuzilma holati (Yo\'l, suv, elektr)',
    'Korrupsiya va ta\'magirlik',
    'Loyihalar sifatsiz bajarilishi',
    'Mablag\'larni talon-toroj qilish',
    'Boshqa masalalar',
  ];

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) return _buildSuccessView();

    return Scaffold(
      backgroundColor: AppColors.surfaceBright,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.account_balance, color: AppColors.primary),
          onPressed: () {},
        ),
        title: const Text('OPEN BUDGET', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primary, letterSpacing: 1.5)),
        actions: [IconButton(icon: const Icon(Icons.location_on, color: AppColors.primary), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
        children: [
          // Header
          Center(
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                border: Border.all(color: AppColors.secondaryContainer),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 4))],
              ),
              child: const Icon(Icons.shield_outlined, size: 40, color: AppColors.secondary),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Anonim shikoyat\nyuborish', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: -0.6, color: AppColors.onBackground)),
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(100)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock, size: 18, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Text('Shaxsingiz sir saqlanishi kafolatlanadi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Form card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 4))],
              border: Border.all(color: AppColors.surfaceContainerLow),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Topic
                const Text('Shikoyat mavzusi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Mavzuni tanlang...', style: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.5))),
                      value: _selectedTopic,
                      items: _topics.map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 16)))).toList(),
                      onChanged: (v) => setState(() => _selectedTopic = v),
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.onSurfaceVariant),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Description
                const Text('Batafsil ma\'lumot', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                const SizedBox(height: 8),
                TextField(
                  controller: _descController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Muammo qayerda va qachon sodir bo\'lganligini, hamda boshqa muhim tafsilotlarni yozing...',
                    hintStyle: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
                  ),
                ),
                const SizedBox(height: 24),

                // File upload area
                const Text('Dalillarni yuklash (ixtiyoriy)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.outlineVariant, width: 2, strokeAlign: BorderSide.strokeAlignInside),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.surface,
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.cloud_upload_outlined, size: 32, color: AppColors.outline),
                      const SizedBox(height: 8),
                      const Text('Rasm, video yoki hujjat yuklang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text('Maksimal hajm: 20 MB. Formatlar: JPG, PNG, MP4, PDF', style: TextStyle(fontSize: 14, color: AppColors.outline), textAlign: TextAlign.center),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Info banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                    border: const Border(left: BorderSide(color: AppColors.primary, width: 4)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, size: 20, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Ushbu tizim orqali yuborilgan barcha ma\'lumotlar shifrlanadi. Sizning IP manzilingiz yoki qurilmangiz haqidagi ma\'lumotlar tizimda saqlanmaydi.',
                          style: TextStyle(fontSize: 14, color: AppColors.onSurface),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSending ? null : _handleSubmit,
                    icon: _isSending
                        ? SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.send, size: 18),
                    label: Text(_isSending ? 'Yuborilmoqda...' : 'Xavfsiz yuborish'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.onSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.secondaryContainer.withValues(alpha: 0.3)),
                child: const Icon(Icons.check_circle, size: 48, color: AppColors.secondary),
              ),
              const SizedBox(height: 24),
              const Text('Xabar yuborildi!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
              const SizedBox(height: 8),
              Text('Sizning anonim shikoyatingiz xavfsiz tarzda yuborildi. Tegishli organlar tomonidan ko\'rib chiqiladi.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => setState(() { _sent = false; _selectedTopic = null; _descController.clear(); }),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Text('Yangi xabar yuborish'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_selectedTopic == null || _descController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Iltimos, mavzu va tavsifni to\'ldiring'),
        backgroundColor: AppColors.error, behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ));
      return;
    }
    HapticFeedback.mediumImpact();
    setState(() => _isSending = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() { _isSending = false; _sent = true; });
  }
}
