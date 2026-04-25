/// Model representing a citizen registered via OneID
class UserModel {
  final String id;
  final String fullName;
  final String pinfl; // Personal Identification Number (PINFL)
  final String region; // Viloyat
  final String district; // Tuman
  final String mahalla; // Mahalla (MFY)
  final String address; // Full propiska address
  final String phoneNumber;
  final DateTime registeredAt;
  final bool hasVoted;
  final String? votedProjectId;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.pinfl,
    required this.region,
    required this.district,
    required this.mahalla,
    required this.address,
    required this.phoneNumber,
    required this.registeredAt,
    this.hasVoted = false,
    this.votedProjectId,
  });

  UserModel copyWith({
    bool? hasVoted,
    String? votedProjectId,
  }) {
    return UserModel(
      id: id,
      fullName: fullName,
      pinfl: pinfl,
      region: region,
      district: district,
      mahalla: mahalla,
      address: address,
      phoneNumber: phoneNumber,
      registeredAt: registeredAt,
      hasVoted: hasVoted ?? this.hasVoted,
      votedProjectId: votedProjectId ?? this.votedProjectId,
    );
  }

  /// Demo user for testing (simulated OneID response)
  static UserModel demoUser() {
    return UserModel(
      id: 'usr_001',
      fullName: 'Abdullayev Javohir Kamoliddin o\'g\'li',
      pinfl: '31234567890123',
      region: 'Toshkent shahri',
      district: 'Sergeli tumani',
      mahalla: 'Yangi Hayot mahallasi',
      address: 'Yangi Hayot mahallasi, 1-tor ko\'cha, 15-uy',
      phoneNumber: '+998 90 123 45 67',
      registeredAt: DateTime.now(),
    );
  }
}
