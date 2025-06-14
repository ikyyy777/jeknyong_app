import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jeknyong_app/controllers/daftar_akun_controller.dart';
import 'package:jeknyong_app/controllers/home_controller.dart';
import 'package:jeknyong_app/controllers/jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/jual_sampah_tanpa_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/kategori_produk_controller.dart';
import 'package:jeknyong_app/controllers/keranjang_jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/oleh_oleh_controller.dart';
import 'package:jeknyong_app/controllers/pembayaran_controller.dart';
import 'package:jeknyong_app/controllers/pilih_lokasi_cari_alamat_controller.dart';
import 'package:jeknyong_app/controllers/pilih_lokasi_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/tarik_saldo_controller.dart';
import 'package:jeknyong_app/controllers/toko_rekomendasi_controller.dart';
import 'package:jeknyong_app/controllers/detail_toko_controller.dart';
import 'package:jeknyong_app/controllers/keranjang_oleh_oleh_controller.dart';
import 'package:jeknyong_app/views/jual_sampah_tanpa_dipilah/jual_sampah_tanpa_dipilah_view.dart';
import 'package:jeknyong_app/views/daftar_akun/daftar_akun_view.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_view.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_view.dart';
import 'package:jeknyong_app/views/jual_sampah_dipilah/jual_sampah_dipilah_view.dart';
import 'package:jeknyong_app/views/keranjang_oleh_oleh/keranjang_oleh_oleh_view.dart';
import 'package:jeknyong_app/views/keranjang_jual_sampah/keranjang_jual_sampah_view.dart';
import 'package:jeknyong_app/views/login/login_view.dart';
import 'package:jeknyong_app/views/metode_pembayaran/metode_pembayaran_view.dart';
import 'package:jeknyong_app/views/navigation_bar/navigation_bar_view.dart';
import 'package:jeknyong_app/views/penarikan_berhasil/penarikan_berhasil_view.dart';
import 'package:jeknyong_app/views/pilih_lokasi/pilih_lokasi_view.dart';
import 'package:jeknyong_app/views/profil/profil_view.dart';
import 'package:jeknyong_app/views/tarik_saldo/tarik_saldo_view.dart';
import 'package:jeknyong_app/views/toko_rekomendasi/toko_rekomendasi_view.dart';
import 'package:jeknyong_app/views/transaksi_berhasil/transaksi_berhasil_view.dart';
import 'package:provider/provider.dart';
import 'package:jeknyong_app/views/splashscreen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Mengunci orientasi layar ke mode portrait saja
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DaftarAkunController()),
        ChangeNotifierProvider(create: (_) => ScaleFactorController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => OlehOlehController()),
        ChangeNotifierProvider(create: (_) => TokoRekomendasiController()),
        ChangeNotifierProvider(create: (_) => KategoriProdukController()),
        ChangeNotifierProvider(create: (_) => DetailTokoController()),
        ChangeNotifierProvider(create: (_) => KeranjangOlehOlehController()),
        ChangeNotifierProvider(create: (_) => PembayaranController()),
        ChangeNotifierProvider(create: (_) => JualSampahDipilahController()),
        ChangeNotifierProvider(
          create: (_) => JualSampahTanpaDipilahController(),
        ),
        ChangeNotifierProvider(create: (_) => PilihLokasiController()),
        ChangeNotifierProvider(
          create: (_) => PilihLokasiCariAlamatController(),
        ),
        ChangeNotifierProxyProvider<JualSampahDipilahController, KeranjangJualSampahDipilahController>(
          create: (context) => KeranjangJualSampahDipilahController(
            Provider.of<JualSampahDipilahController>(context, listen: false),
          ),
          update: (context, jualSampahController, previous) => 
            previous ?? KeranjangJualSampahDipilahController(jualSampahController),
        ),
        ChangeNotifierProvider(create: (_) => TarikSaldoController()),
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
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginView(),
        '/daftar-akun': (context) => const DaftarAkunView(),
        '/lengkapi-data-1': (context) => const LengkapiData1View(),
        '/lengkapi-data-2': (context) => const LengkapiData2View(),
        '/navigation-bar': (context) => const NavigationBarView(),
        '/toko-rekomendasi': (context) => const TokoRekomendasiView(),
        '/keranjang-oleh-oleh': (context) => const KeranjangOlehOlehView(),
        '/metode-pembayaran': (context) => const MetodePembayaranView(),
        '/anorganik-tanpa-dipilah':
            (context) => const AnorganikTanpaDipilahView(),
        '/jual-sampah-dipilah': (context) => const JualSampahDipilahView(),
        '/transaksi-berhasil': (context) => const TransaksiBerhasilView(),
        '/pilih-lokasi': (context) => PilihLokasiView(),
        '/keranjang-sampah': (context) => const KeranjangJualSampahView(),
        '/tarik-saldo': (context) => const TarikSaldoView(),
        '/penarikan-berhasil': (context) => const PenarikanBerhasilView(),
      },
    );
  }
}
