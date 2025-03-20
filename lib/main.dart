import 'package:flutter/material.dart';
import 'package:jeknyong_app/utils/navigation_service.dart';
import 'package:jeknyong_app/views/Daftar%20Akun/daftar_akun_view.dart';
import 'package:jeknyong_app/views/Login/login_view.dart';
import 'package:provider/provider.dart';
import 'package:jeknyong_app/dummy_controller/dummy_controller.dart';
import 'package:jeknyong_app/views/Splash Screen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DummyController()),
        Provider(create: (_) => NavigationService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeknyong App',
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: const SplashScreen(),
      navigatorKey: context.read<NavigationService>().navigatorKey,
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginView(),
        '/daftar-akun': (context) => const DaftarAkunView(),
      },
    );
  }
}