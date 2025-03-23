
import 'package:flutter/material.dart';
import 'package:jeknyong_app/models/kategori_produk_content_model.dart';

class KategoriProdukController extends ChangeNotifier {
  final List<KategoriProdukContent> listKategoriProduk = [
    KategoriProdukContent(
      image: 'assets/images/qiis_petshop.png',
      name: 'Qiis Petshop',
      category: 'Hobi dan Koleksi', 
      rating: 4.5,
      distance: 2.5,
    ),
    KategoriProdukContent(
      image: 'assets/images/anisa_furniture.png',
      name: 'Anisa Furniture',
      category: 'Furniture',
      rating: 4.8,
      distance: 1.2,
    ),
    KategoriProdukContent(
      image: 'assets/images/sablon_kaos.png',
      name: 'Sablon Kaos',
      category: 'Fashion',
      rating: 4.3,
      distance: 3.0,
    ),
    KategoriProdukContent(
      image: 'assets/images/quinn_mart.png',
      name: 'Quinn Mart',
      category: 'Toko Sembako',
      rating: 4.3,
      distance: 3.0,
    ),
  ];
}
