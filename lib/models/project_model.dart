/// Model representing an Open Budget project proposal
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String mahalla;
  final String district;
  final String location;
  final double budgetAmount; // in UZS
  final String budgetFormatted;
  final int voteCount; // Hidden from users until deadline
  final bool votesHidden;
  final DateTime deadline;
  final String? imageUrl;
  final ProjectStatus status;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.mahalla,
    required this.district,
    required this.location,
    required this.budgetAmount,
    required this.budgetFormatted,
    this.voteCount = 0,
    this.votesHidden = true,
    required this.deadline,
    this.imageUrl,
    this.status = ProjectStatus.active,
  });

  /// Check if a given mahalla matches this project's mahalla
  bool belongsToMahalla(String userMahalla) {
    return mahalla.toLowerCase() == userMahalla.toLowerCase();
  }

  /// Demo projects for the Yangi Hayot mahalla
  static List<ProjectModel> demoProjects() {
    return [
      ProjectModel(
        id: 'prj_001',
        title: 'Ichki ko\'chalarni asfalt qoplama bilan ta\'mirlash',
        description:
            'Ushbu loyiha doirasida Yangi Hayot mahallasi hududidagi ichki '
            'ko\'chalarni zamonaviy asfalt qoplama bilan ta\'mirlash '
            'rejalashtirilgan. Yo\'l chetlarida piyodalar yo\'lkasi va '
            'yomg\'ir suvi oqizish tizimlari ham barpo etiladi.',
        category: "Yo'l ta'mirlash",
        mahalla: 'Yangi Hayot mahallasi',
        district: 'Sergeli tumani',
        location: 'Yangi Hayot mahallasi, 1-tor ko\'cha',
        budgetAmount: 1200000000,
        budgetFormatted: '1.2 mlrd so\'m',
        voteCount: 347,
        votesHidden: true,
        deadline: DateTime(2026, 6, 15),
        status: ProjectStatus.active,
      ),
      ProjectModel(
        id: 'prj_002',
        title: '2-sonli maktab sport zalini zamonaviy anjomlar bilan jihozlash',
        description:
            '2-sonli umumta\'lim maktabining sport zalini to\'liq '
            'rekonstruksiya qilish va zamonaviy sport anjomlarini o\'rnatish. '
            'Shu bilan birga, maktab hovlisida ochiq sport maydoni (workout '
            'area) barpo etish ham rejalashtirilgan.',
        category: "Ta'lim",
        mahalla: 'Yangi Hayot mahallasi',
        district: 'Sergeli tumani',
        location: 'Yangi Hayot mahallasi',
        budgetAmount: 450000000,
        budgetFormatted: '450 mln so\'m',
        voteCount: 215,
        votesHidden: true,
        deadline: DateTime(2026, 6, 15),
        status: ProjectStatus.active,
      ),
      ProjectModel(
        id: 'prj_003',
        title: '"Navbahor" mahallasida yangi bolalar maydonchasi qurish',
        description:
            'Ushbu loyiha doirasida "Navbahor" mahallasi hududida zamonaviy '
            'bolalar maydonchasi va sport maydonchasi (workout area) barpo '
            'etish rejalashtirilgan. Hududda yoritish tizimlari, o\'rindiqlar '
            'va obodonlashtirish ishlari ham amalga oshiriladi.',
        category: 'Obodonlashtirish',
        mahalla: 'Yangi Hayot mahallasi',
        district: 'Sergeli tumani',
        location: 'Navbahor MFY, Yangi Hayot tumani',
        budgetAmount: 1200000000,
        budgetFormatted: '1 200 000 000 UZS',
        voteCount: 189,
        votesHidden: true,
        deadline: DateTime(2026, 6, 15),
        imageUrl: 'playground',
        status: ProjectStatus.active,
      ),
      ProjectModel(
        id: 'prj_004',
        title: 'Qumariq mahallasi uchun yangi suv minorasi qurish',
        description:
            'Qumariq mahallasi aholisini toza ichimlik suvi bilan '
            'ta\'minlash maqsadida yangi suv minorasi qurish loyihasi. '
            'Mavjud suv tarmoqlari ham yangilanadi.',
        category: 'Ichimlik suvi',
        mahalla: 'Qumariq mahallasi',
        district: 'Sergeli tumani',
        location: 'Qumariq mahallasi',
        budgetAmount: 850000000,
        budgetFormatted: '850 mln so\'m',
        voteCount: 120,
        votesHidden: true,
        deadline: DateTime(2026, 6, 15),
        status: ProjectStatus.active,
      ),
      ProjectModel(
        id: 'prj_005',
        title: 'Mahalla markazini rekonstruksiya qilish',
        description:
            'Yangi Hayot mahallasi markazini zamonaviy talablarga mos '
            'ravishda ta\'mirlash va jihozlash. Aholini qabul qilish '
            'xonalari, yig\'ilishlar zali va kutish xonasi yaratiladi.',
        category: 'Infratuzilma',
        mahalla: 'Yangi Hayot mahallasi',
        district: 'Sergeli tumani',
        location: 'Yangi Hayot mahallasi markazi',
        budgetAmount: 680000000,
        budgetFormatted: '680 mln so\'m',
        voteCount: 156,
        votesHidden: true,
        deadline: DateTime(2026, 6, 15),
        status: ProjectStatus.active,
      ),
    ];
  }
}

enum ProjectStatus {
  active,
  completed,
  rejected,
}
