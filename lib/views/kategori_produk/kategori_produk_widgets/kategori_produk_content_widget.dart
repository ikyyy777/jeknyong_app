import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/kategori_produk_controller.dart';
import 'package:jeknyong_app/global_widget/kategori_produk_content_global_widget.dart';
import 'package:provider/provider.dart';

class KategoriProdukContentWidget extends StatefulWidget {
  const KategoriProdukContentWidget({super.key});

  @override
  State<KategoriProdukContentWidget> createState() => _KategoriProdukContentWidgetState();
}

class _KategoriProdukContentWidgetState extends State<KategoriProdukContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount:
            context
                .watch<KategoriProdukController>()
                .listKategoriProduk
                .length,
        itemBuilder: (context, index) {
          final kategoriProduk =
              context
                  .read<KategoriProdukController>()
                  .listKategoriProduk[index];
          return KategoriProdukContentGlobalWidget(kategoriProduk: kategoriProduk);
        },
      ),
    );
  }
}