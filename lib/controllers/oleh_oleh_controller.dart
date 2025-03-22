import 'package:flutter/material.dart';
import 'package:jeknyong_app/models/toko_rekomendasi_model.dart';

class OlehOlehController extends ChangeNotifier {
  final List<String> olehOlehBanner = [
    "assets/images/banner2.png",
    "assets/images/banner3.png",
  ];

  final List<TokoRekomendasi> tokoRekomendasi = [
    TokoRekomendasi(
      image: 'assets/images/qiis_petshop.png',
      name: 'Qiis Petshop',
      category: 'Hobi dan Koleksi',
      rating: 4.5,
      distance: 2.5,
    ),
    TokoRekomendasi(
      image: 'assets/images/anisa_furniture.png',
      name: 'Anisa Furniture',
      category: 'Furniture',
      rating: 4.8,
      distance: 1.2,
    ),
    TokoRekomendasi(
      image: 'assets/images/sablon_kaos.png',
      name: 'Sablon Kaos',
      category: 'Fashion',
      rating: 4.3,
      distance: 3.0,
    ),
    TokoRekomendasi(
      image: 'assets/images/quinn_mart.png',
      name: 'Quinn Mart',
      category: 'Toko Sembako',
      rating: 4.3,
      distance: 3.0,
    ),
  ];
}

