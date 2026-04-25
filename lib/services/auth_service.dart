import 'package:flutter/material.dart';
import '../models/user_model.dart';

/// Simulated OneID Authentication Service
class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  /// Simulate OneID login flow
  Future<bool> loginWithOneID() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _currentUser = UserModel.demoUser();
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Vote for a project (1 vote per season, free)
  bool voteForProject(String projectId) {
    if (_currentUser == null || _currentUser!.hasVoted) return false;

    _currentUser = _currentUser!.copyWith(
      hasVoted: true,
      votedProjectId: projectId,
    );
    notifyListeners();
    return true;
  }

  /// Logout
  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
