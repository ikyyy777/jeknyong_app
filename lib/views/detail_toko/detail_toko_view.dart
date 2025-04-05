import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/detail_toko/detail_toko_widgets/detail_toko_deskripsi_widget.dart';
import 'package:jeknyong_app/views/detail_toko/detail_toko_widgets/detail_toko_image_banner_widget.dart';
import 'package:jeknyong_app/views/detail_toko/detail_toko_widgets/detail_toko_produk_widget.dart';
import 'package:provider/provider.dart';

class DetailTokoView extends StatefulWidget {
  final String tokoName;

  const DetailTokoView({super.key, required this.tokoName});

  @override
  State<DetailTokoView> createState() => _DetailTokoViewState();
}

class _DetailTokoViewState extends State<DetailTokoView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailTokoImageBannerWidget(tokoName: widget.tokoName),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              DetailTokoDeskripsiWidget(tokoName: widget.tokoName),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              DetailTokoProdukWidget(tokoName: widget.tokoName),
            ],
          ),
        ),
      ),
    );
  }
}
