import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/utils/navigation_service.dart';
import 'package:jeknyong_app/views/daftar_akun/daftar_akun_view.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_view.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_view.dart';
import 'package:jeknyong_app/views/login/login_view.dart';
import 'package:provider/provider.dart';
import 'package:jeknyong_app/views/splashscreen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => NavigationService()),
        ChangeNotifierProvider(create: (_) => DaftarAkunController()),
        ChangeNotifierProvider(create: (_) => ScaleFactorController()),
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
        '/lengkapi-data-1': (context) => const LengkapiData1View(),
        '/lengkapi-data-2': (context) => const LengkapiData2View(),
      },
    );
  }
}