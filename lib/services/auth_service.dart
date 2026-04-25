import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'google_sheets_service.dart';

/// OneID Authentication Service with Google Sheets backend
class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _sheetsUserId; // User ID from Google Sheets

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  /// Simulate OneID login + register to Google Sheets
  Future<bool> loginWithOneID() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _currentUser = UserModel.demoUser();
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();

    // Register user in Google Sheets (background)
    _registerInSheets();

    return true;
  }

  /// Register user data in Google Sheets
  Future<void> _registerInSheets() async {
    if (_currentUser == null) return;
    final user = _currentUser!;

    final result = await GoogleSheetsService.registerUser(
      fullName: user.fullName,
      pinfl: user.pinfl,
      phone: user.phoneNumber,
      region: user.region,
      district: user.district,
      mahalla: user.mahalla,
      address: user.address,
    );

    if (result['success'] == true) {
      _sheetsUserId = result['user_id'];
      debugPrint('[Auth] Registered in Sheets: $_sheetsUserId');

      // If user already voted (from previous session)
      if (result['already_voted'] == true) {
        _currentUser = _currentUser!.copyWith(
          hasVoted: true,
          votedProjectId: result['voted_project_id']?.toString(),
        );
        notifyListeners();
      }
    }
  }

  /// Vote for a project + record in Google Sheets
  Future<bool> voteForProject(String projectId) async {
    if (_currentUser == null || _currentUser!.hasVoted) return false;

    _currentUser = _currentUser!.copyWith(
      hasVoted: true,
      votedProjectId: projectId,
    );
    notifyListeners();

    // Record vote in Google Sheets (background)
    GoogleSheetsService.recordVote(
      userId: _sheetsUserId ?? 'unknown',
      projectId: projectId,
      mahalla: _currentUser!.mahalla,
    );

    return true;
  }

  /// Logout
  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    _sheetsUserId = null;
    notifyListeners();
  }
}

// 
