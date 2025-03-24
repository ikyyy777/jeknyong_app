import 'package:flutter/material.dart';
import 'package:jeknyong_app/models/detail_toko_model.dart';

class DetailTokoController extends ChangeNotifier {
  // Map untuk menyimpan variant yang dipilih untuk setiap produk
  // Key: productName, Value: selected variant name
  Map<String, String> selectedVariants = {};

  void selectVariant(String productName, String variantName) {
    selectedVariants[productName] = variantName;
    notifyListeners();
  }

  bool isVariantSelected(String productName, String variantName) {
    return selectedVariants[productName] == variantName;
  }

  // Mendapatkan harga total (base price + additional price dari variant yang dipilih)
  double getTotalPrice(String productName, double basePrice) {
    String? selectedVariant = selectedVariants[productName];
    if (selectedVariant == null) return basePrice;

    // Cari produk dan variantnya
    for (var toko in detailToko.values) {
      for (var product in toko.products) {
        if (product.name == productName) {
          var variant = product.variants!.firstWhere(
            (v) => v.name == selectedVariant,
            orElse: () => ProductVariant(name: '', additionalPrice: 0),
          );
          return basePrice + (variant.additionalPrice ?? 0);
        }
      }
    }
    return basePrice;
  }

  final Map<String, DetailToko> detailToko = {
    'Qiis Petshop': DetailToko(
      image: 'assets/images/qiis_petshop.png',
      name: 'Qiis Petshop',
      category: 'Hobi dan Koleksi',
      rating: 4.5,
      totalReview: 120,
      distance: 2.5,
      address: 'Jl. Raya Qiis No. 123, Malang',
      operationalHours: OperationalHours(open: '08:00', close: '21:00'),
      gallery: [
        'assets/images/qiis_petshop.png',
        'assets/images/qiis_petshop.png',
        'assets/images/qiis_petshop.png',
      ],
      products: [
        Product(
          name: 'Royal Canin',
          image: 'assets/images/royal_canin.png',
          price: 90000,
          terjual: 50,
          description:
              'Royal Canin adalah brand makanan khusus untuk hewan peliharaan.',
          typeVariant: 'Ukuran',
          variants: [
            ProductVariant(name: '1 kg', additionalPrice: 0),
            ProductVariant(name: '3 kg', additionalPrice: 150000),
            ProductVariant(name: '5 kg', additionalPrice: 250000),
          ],
        ),
        Product(
          name: 'Whiskas',
          image: 'assets/images/whiskas.png',
          price: 45000,
          terjual: 30,
          description: 'Whiskas makanan kucing premium dengan nutrisi lengkap.',
          typeVariant: 'Rasa',
          variants: [
            ProductVariant(name: 'Tuna', additionalPrice: 0),
            ProductVariant(name: 'Salmon', additionalPrice: 5000),
            ProductVariant(name: 'Chicken', additionalPrice: 2000),
          ],
        ),
      ],
    ),
    'Anisa Furniture': DetailToko(
      image: 'assets/images/anisa_furniture.png',
      name: 'Anisa Furniture',
      category: 'Furniture',
      rating: 4.8,
      totalReview: 200,
      distance: 1.2,
      address: 'Jl. Raya Anisa No. 45, Malang',
      operationalHours: OperationalHours(open: '09:00', close: '20:00'),
      gallery: [
        'assets/images/anisa_furniture.png',
        'assets/images/anisa_furniture.png',
        'assets/images/anisa_furniture.png',
      ],
      products: [
        Product(
          name: 'Sofa Minimalis',
          image: 'assets/images/sofa.png',
          price: 2500000,
          terjual: 10,
          description: 'Sofa minimalis dengan bahan premium.',
          typeVariant: 'Warna',
          variants: [
            ProductVariant(name: 'Cream', additionalPrice: 0),
            ProductVariant(name: 'Grey', additionalPrice: 100000),
            ProductVariant(name: 'Navy', additionalPrice: 150000),
          ],
        ),
        Product(
          name: 'Meja Makan',
          image: 'assets/images/meja_makan.png',
          price: 1500000,
          terjual: 15,
          description:
              'Meja makan dengan desain modern dan klasik. Menyediakan berbagai furniture untuk rumah Anda.',
          typeVariant: 'Ukuran',
          variants: [
            ProductVariant(name: 'S', additionalPrice: 0),
            ProductVariant(name: 'M', additionalPrice: 0),
            ProductVariant(name: 'L', additionalPrice: 0),
            ProductVariant(name: 'XL', additionalPrice: 0),
          ],
        ),
      ],
    ),
    'Sablon Kaos': DetailToko(
      image: 'assets/images/sablon_kaos_banner.png',
      name: 'Sablon Kaos',
      category: 'Fashion',
      rating: 4.3,
      totalReview: 150,
      distance: 3.0,
      address: 'Jl. Raya Sablon No. 67, Malang',
      operationalHours: OperationalHours(open: '08:00', close: '17:00'),
      gallery: [
        'assets/images/produk1.png',
        'assets/images/produk1.png',
        'assets/images/produk1.png',
      ],
      products: [
        Product(
          name: 'Kaos Polos',
          image: 'assets/images/produk1.png',
          price: 50000,
          terjual: 100,
          description:
              'Kaos polos dengan desain modern dan klasik. Menyediakan berbagai furniture untuk rumah Anda.',
          typeVariant: 'Ukuran',
          variants: [
            ProductVariant(name: 'S', additionalPrice: 0),
            ProductVariant(name: 'M', additionalPrice: 0),
            ProductVariant(name: 'L', additionalPrice: 0),
            ProductVariant(name: 'XL', additionalPrice: 0),
          ],
        ),
        Product(
          name: 'Sweater Rajut Premium Unisex',
          image: 'assets/images/produk2.png',
          price: 25000,
          terjual: 200,
          description:
              'Sweater Rajut Reguler Fit dengan tekstur Cable yang menggunakan bahan Premium Knit yang lembut.  Perpaduan antara desain klasik dengan zipper modern yang memberikan kesan stylish.',
          typeVariant: 'Ukuran',
          variants: [
            ProductVariant(name: 'S', additionalPrice: 0),
            ProductVariant(name: 'M', additionalPrice: 0),
            ProductVariant(name: 'L', additionalPrice: 0),
            ProductVariant(name: 'XL', additionalPrice: 0),
          ],
        ),
      ],
    ),
    'Quinn Mart': DetailToko(
      image: 'assets/images/quinn_mart.png',
      name: 'Quinn Mart',
      category: 'Toko Sembako',
      rating: 4.3,
      totalReview: 180,
      distance: 3.0,
      address: 'Jl. Raya Quinn No. 89, Malang',
      operationalHours: OperationalHours(open: '07:00', close: '22:00'),
      gallery: [
        'assets/images/quinn_mart.png',
        'assets/images/quinn_mart.png',
        'assets/images/quinn_mart.png',
      ],
      products: [
        Product(
          name: 'Beras 5kg',
          image: 'assets/images/beras.png',
          price: 65000,
          terjual: 80,
          description:
              'Beras 5kg dengan harga bersaing. Menyediakan berbagai kebutuhan pokok sehari-hari.',
          typeVariant: 'Ukuran',
          variants: [
            ProductVariant(name: 'S', additionalPrice: 0),
            ProductVariant(name: 'M', additionalPrice: 0),
            ProductVariant(name: 'L', additionalPrice: 0),
            ProductVariant(name: 'XL', additionalPrice: 0),
          ],
        ),
        Product(
          name: 'Minyak Goreng 2L',
          image: 'assets/images/minyak_goreng.png',
          price: 35000,
          terjual: 120,
          description:
              'Minyak goreng 2L dengan harga bersaing. Menyediakan berbagai kebutuhan pokok sehari-hari.',
          typeVariant: 'Ukuran',
          variants: [
            ProductVariant(name: 'S', additionalPrice: 0),
            ProductVariant(name: 'M', additionalPrice: 0),
            ProductVariant(name: 'L', additionalPrice: 0),
            ProductVariant(name: 'XL', additionalPrice: 0),
          ],
        ),
      ],
    ),
  };
}
