import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/home_controller.dart';
import 'package:jeknyong_app/controllers/kategori_produk_controller.dart';
import 'package:jeknyong_app/controllers/oleh_oleh_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/toko_rekomendasi_controller.dart';
import 'package:jeknyong_app/controllers/detail_toko_controller.dart';
import 'package:jeknyong_app/controllers/keranjang_controller.dart';
import 'package:jeknyong_app/utils/navigation_service.dart';
import 'package:jeknyong_app/views/daftar_akun/daftar_akun_view.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_view.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_view.dart';
import 'package:jeknyong_app/views/detail_toko/detail_toko_view.dart';
import 'package:jeknyong_app/views/keranjang_oleh_oleh/keranjang_oleh_oleh_view.dart';
import 'package:jeknyong_app/views/login/login_view.dart';
import 'package:jeknyong_app/views/navigation_bar/navigation_bar_view.dart';
import 'package:jeknyong_app/views/oleh_oleh/oleh_oleh_view.dart';
import 'package:jeknyong_app/views/toko_rekomendasi/toko_rekomendasi_view.dart';
import 'package:provider/provider.dart';
import 'package:jeknyong_app/views/splashscreen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => NavigationService()),
        ChangeNotifierProvider(create: (_) => DaftarAkunController()),
        ChangeNotifierProvider(create: (_) => ScaleFactorController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => OlehOlehController()),
        ChangeNotifierProvider(create: (_) => TokoRekomendasiController()),
        ChangeNotifierProvider(create: (_) => KategoriProdukController()),
        ChangeNotifierProvider(create: (_) => DetailTokoController()),
        ChangeNotifierProvider(create: (_) => KeranjangController()),
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
        '/navigation-bar': (context) => const NavigationBarView(),
        '/oleh-oleh': (context) => const OlehOlehView(),
        '/toko-rekomendasi': (context) => const TokoRekomendasiView(),
        '/keranjang-oleh-oleh': (context) => const KeranjangOlehOlehView(),
      },
    );
  }
}