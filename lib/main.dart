import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/my_votes_screen.dart';
import 'screens/report_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const OpenBudgetApp());
}

class OpenBudgetApp extends StatefulWidget {
  const OpenBudgetApp({super.key});

  @override
  State<OpenBudgetApp> createState() => _OpenBudgetAppState();
}

class _OpenBudgetAppState extends State<OpenBudgetApp> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Budget - O\'zbekiston',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: ListenableBuilder(
        listenable: _authService,
        builder: (context, _) {
          if (_authService.isAuthenticated) {
            return MainShell(authService: _authService);
          }
          return LoginScreen(authService: _authService);
        },
      ),
    );
  }
}

/// Main shell with bottom navigation
class MainShell extends StatefulWidget {
  final AuthService authService;
  const MainShell({super.key, required this.authService});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(authService: widget.authService),
          MyVotesScreen(authService: widget.authService),
          const ReportScreen(),
          ProfileScreen(
            authService: widget.authService,
            onLogout: () => widget.authService.logout(),
          ),
        ],
      ),
      bottomNavigationBar: OpenBudgetBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

// 

// good luck everyone
