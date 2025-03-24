class DetailToko {
  final String image;
  final String name;
  final String category;
  final double rating;
  final int totalReview;
  final double distance;
  final String address;
  final OperationalHours operationalHours;
  final List<String> gallery;
  final List<Product> products;

  DetailToko({
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
    required this.totalReview,
    required this.distance,
    required this.address,
    required this.operationalHours,
    required this.gallery,
    required this.products,
  });
}

class OperationalHours {
  final String open;
  final String close;

  OperationalHours({
    required this.open,
    required this.close,
  });
}

class Product {
  final String name;
  final String image;
  final double price;
  final int terjual;
  final String description;
  final String? typeVariant;
  final List<ProductVariant>? variants;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.terjual,
    required this.description,
    this.typeVariant,
    this.variants,
  });
}

class ProductVariant {
  final String name;
  final double? additionalPrice;
  bool isSelected;

  ProductVariant({
    required this.name,
    this.additionalPrice,
    this.isSelected = false,
  });
}