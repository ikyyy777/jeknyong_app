import 'package:flutter/material.dart';
import 'package:jeknyong_app/models/detail_toko_model.dart';
import 'package:jeknyong_app/models/item_keranjang_model.dart';

class KeranjangController extends ChangeNotifier {
  final List<ItemKeranjangModel> _items = [];

  List<ItemKeranjangModel> get items => _items;

  void addToCart(Product product, String selectedVariant) {
    // Cek apakah produk sudah ada di keranjang dengan variant yang sama
    final existingItemIndex = _items.indexWhere(
      (item) => item.product.name == product.name && 
                item.selectedVariant == selectedVariant,
    );

    if (existingItemIndex != -1) {
      // Jika sudah ada, tambah quantity
      _items[existingItemIndex].quantity++;
    } else {
      // Jika belum ada, tambah item baru
      _items.add(ItemKeranjangModel(
        product: product,
        selectedVariant: selectedVariant,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity < 1) return;
    _items[index].quantity = quantity;
    notifyListeners();
  }

  double getTotalPrice() {
    return _items.fold(0, (total, item) {
      final basePrice = item.product.price;
      final variant = item.product.variants!.firstWhere(
        (v) => v.name == item.selectedVariant,
      );
      final variantPrice = variant.additionalPrice ?? 0;
      return total + ((basePrice + variantPrice) * item.quantity);
    });
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
} 