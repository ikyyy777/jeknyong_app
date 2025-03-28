import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/pembayaran_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LakukanPembayaranView extends StatefulWidget {
  final double totalHarga;
  final PaymentMethod? metodePembayaran;
  final Bank? bank;

  const LakukanPembayaranView({
    super.key,
    required this.totalHarga,
    this.metodePembayaran,
    this.bank,
  });

  @override
  State<LakukanPembayaranView> createState() => _LakukanPembayaranViewState();
}

class _LakukanPembayaranViewState extends State<LakukanPembayaranView> {
  final formatCurrency = NumberFormat.decimalPattern('id');

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    final isQris = widget.bank?.id == 'qris';

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Column(
        children: [
          CustomAppbarGlobalWidget(title: "Lakukan Pembayaran"),
          if (isQris)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: scaleHelper.scaleHeight(8)),
                  Image.asset(
                    'assets/images/qris_big.png',
                    width: scaleHelper.scaleWidth(102),
                    height: scaleHelper.scaleHeight(40),
                  ),
                  Image.asset(
                    'assets/images/dummy_qr_code.png',
                    width: scaleHelper.scaleWidth(235),
                    height: scaleHelper.scaleHeight(206),
                  ),
                  Text(
                    "Unduh Gambar QR",
                    style: TextStyleConstant.textStyleSemiBold.copyWith(
                      fontSize: scaleHelper.scaleText(12),
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  SizedBox(height: scaleHelper.scaleHeight(13)),
                  Text(
                    "Rp ${formatCurrency.format(widget.totalHarga)}",
                    style: TextStyleConstant.textStyleBold.copyWith(
                      fontSize: scaleHelper.scaleText(24),
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  SizedBox(height: scaleHelper.scaleHeight(29)),
                  Text(
                    "Selesaikan Pembayaran",
                    style: TextStyleConstant.textStyleBold.copyWith(
                      fontSize: scaleHelper.scaleText(20),
                    ),
                  ),
                  SizedBox(height: scaleHelper.scaleHeight(8)),
                  Text(
                    textAlign: TextAlign.center,
                    "Terima kasih sudah berbelanja. Silahkan lakukan pembayaran dengan memindai kode QR di atas sebelum 25 Oktober 2021, pukul 19:47 WIB",
                    style: TextStyleConstant.textStyleRegular.copyWith(
                      fontSize: scaleHelper.scaleText(14),
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Pembayaran Belum Tersedia",
                    style: TextStyleConstant.textStyleSemiBold.copyWith(
                      fontSize: scaleHelper.scaleText(16),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        height: scaleHelper.scaleHeight(97),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Container(
          height: scaleHelper.scaleHeight(40),
          margin: EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            onPressed: () {
              // Tambahkan navigasi ke halaman status pembayaran
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Cek Status Pembayaran',
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
