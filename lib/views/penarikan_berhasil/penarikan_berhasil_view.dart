import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class PenarikanBerhasilView extends StatefulWidget {
  const PenarikanBerhasilView({super.key});

  @override
  State<PenarikanBerhasilView> createState() => _PenarikanBerhasilViewState();
}

class _PenarikanBerhasilViewState extends State<PenarikanBerhasilView>
    with TickerProviderStateMixin {
  late GifController _controller;
  bool _showStaticImage = false;

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);

    // Menunggu gif selesai diputar kemudian menampilkan gambar statis
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showStaticImage = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: scaleHelper.scaleHeight(80)),
              if (_showStaticImage)
                Image(image: AssetImage("assets/images/sukses.png"))
              else
                Gif(
                  image: AssetImage("assets/gifs/sukses.gif"),
                  controller: _controller,
                  autostart: Autostart.once,
                  duration: const Duration(seconds: 3),
                ),
          
              Text(
                "Penarikan Berhasil",
                style: TextStyleConstant.textStyleSemiBold.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Text(
                "Selamat kamu berhasil melakukan tarik saldo. Proses penarikan saldo maksimal adalah 2x24 Jam dihari kerja Kecuali hari Minggu",
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: 16,
                  color: ColorConstant.darkColor3,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: scaleHelper.scaleHeight(97),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          height: scaleHelper.scaleHeight(40),
          margin: EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/navigation-bar',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Kembali ke Beranda',
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
