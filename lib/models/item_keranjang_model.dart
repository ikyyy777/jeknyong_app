import 'package:jeknyong_app/models/detail_toko_model.dart';

class ItemKeranjangModel {
  final Product product;
  final String selectedVariant;
  int quantity;

  ItemKeranjangModel({
    required this.product,
    required this.selectedVariant,
    this.quantity = 1,
  });
}