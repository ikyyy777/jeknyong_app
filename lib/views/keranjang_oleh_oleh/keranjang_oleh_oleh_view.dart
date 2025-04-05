import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/keranjang_oleh_oleh_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:jeknyong_app/views/keranjang_oleh_oleh/keranjang_oleh_oleh_widget/keranjang_oleh_oleh_alamat_widget.dart';
import 'package:jeknyong_app/views/keranjang_oleh_oleh/keranjang_oleh_oleh_widget/keranjang_oleh_oleh_daftar_produk_widget.dart';
import 'package:jeknyong_app/views/keranjang_oleh_oleh/keranjang_oleh_oleh_widget/keranjang_oleh_oleh_informasi_tambahan_widget.dart';
import 'package:jeknyong_app/views/keranjang_oleh_oleh/keranjang_oleh_oleh_widget/keranjang_oleh_oleh_rincian_biaya_widget.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class KeranjangOlehOlehView extends StatefulWidget {
  const KeranjangOlehOlehView({super.key});

  @override
  State<KeranjangOlehOlehView> createState() => _KeranjangOlehOlehViewState();
}

class _KeranjangOlehOlehViewState extends State<KeranjangOlehOlehView> {
  final formatCurrency = NumberFormat.decimalPattern('id');

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Consumer<KeranjangOlehOlehController>(
      builder: (context, keranjangController, child) {
        final isKeranjangEmpty = keranjangController.items.isEmpty;
        final totalHarga = keranjangController.getTotalPrice() + 10000; // Termasuk ongkir

        return Scaffold(
          backgroundColor: ColorConstant.greyColor2,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbarGlobalWidget(title: 'Keranjang Oleh-Olehe Nyong'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: scaleHelper.scaleHeight(16)),
                      KeranjangOlehOlehAlamatWidget(),
                      SizedBox(height: scaleHelper.scaleHeight(16)),
                      KeranjangOlehOlehDaftarProdukWidget(),
                      if (!isKeranjangEmpty) ...[
                        SizedBox(height: scaleHelper.scaleHeight(16)),
                        KeranjangOlehOlehRincianBiayaWidget(),
                        SizedBox(height: scaleHelper.scaleHeight(16)),
                        KeranjangOlehOlehInformasiTambahanWidget(),
                      ],
                      SizedBox(height: scaleHelper.scaleHeight(25)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: isKeranjangEmpty
              ? null
              : Container(
                  height: scaleHelper.scaleHeight(97),
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scaleHelper.scaleWidth(16),
                      vertical: scaleHelper.scaleHeight(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Total',
                              style: TextStyleConstant.textStyleRegular.copyWith(
                                fontSize: scaleHelper.scaleText(14),
                                color: ColorConstant.darkColor2,
                              ),
                            ),
                            Text(
                              'Rp ${formatCurrency.format(totalHarga)}',
                              style: TextStyleConstant.textStyleBold.copyWith(
                                fontSize: scaleHelper.scaleText(16),
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Implementasi navigasi ke halaman pembayaran
                            Navigator.pushNamed(context, '/metode-pembayaran');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleHelper.scaleWidth(24),
                              vertical: scaleHelper.scaleHeight(12),
                            ),
                          ),
                          child: Text(
                            'Pilih Pembayaran',
                            style: TextStyleConstant.textStyleSemiBold.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                              color: ColorConstant.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
