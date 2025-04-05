import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/kategori_produk/widgets/kategori_produk_content_widget.dart';
import 'package:jeknyong_app/views/kategori_produk/widgets/kategori_produk_header_widget.dart';
import 'package:provider/provider.dart';

class KategoriProdukView extends StatefulWidget {
  final String kategori;
  const KategoriProdukView({
    super.key,
    required this.kategori,
  });

  @override
  State<KategoriProdukView> createState() => _KategoriProdukViewState();
}

class _KategoriProdukViewState extends State<KategoriProdukView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleHelper.scaleWidth(16)),
          child: Column(
            children: [
              SizedBox(height: scaleHelper.scaleHeight(24)),
              KategoriProdukHeaderWidget(kategori: widget.kategori),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              KategoriProdukContentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}