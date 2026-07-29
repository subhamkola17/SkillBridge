import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'services/api_service.dart';
import 'theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: const SkillBridgeApp(),
    ),
  );
}

class SkillBridgeApp extends StatelessWidget {
  const SkillBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillBridge',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}