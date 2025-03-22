import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/oleh_oleh/oleh_oleh_widget/oleh_oleh_banner_widget.dart';
import 'package:jeknyong_app/views/oleh_oleh/oleh_oleh_widget/oleh_oleh_kategori_produk_widget.dart';
import 'package:jeknyong_app/views/oleh_oleh/oleh_oleh_widget/oleh_oleh_lokasi_widget.dart';
import 'package:jeknyong_app/views/oleh_oleh/oleh_oleh_widget/oleh_oleh_search_bar_widget.dart';
import 'package:jeknyong_app/views/oleh_oleh/oleh_oleh_widget/oleh_oleh_toko_rekomendasi_widget.dart';
import 'package:provider/provider.dart';

class OlehOlehView extends StatefulWidget {
  const OlehOlehView({super.key});

  @override
  State<OlehOlehView> createState() => _OlehOlehViewState();
}

class _OlehOlehViewState extends State<OlehOlehView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OlehOlehLokasiWidget(),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            OlehOlehSearchBarWidget(),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            OlehOlehBannerWidget(),
            SizedBox(height: scaleHelper.scaleHeight(24)),
            OlehOlehKategoriProdukWidget(),
            SizedBox(height: scaleHelper.scaleHeight(24)),
            OlehOlehTokoRekomendasiWidget(),
            SizedBox(height: scaleHelper.scaleHeight(24)),
          ],
        ),
      ),
    );
  }
}
