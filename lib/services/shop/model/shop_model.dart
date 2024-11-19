
class ShopCategory {
  final int id;
  final String imageUrl;
  final String title;
  final List<ShopProduct> products;

  ShopCategory(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.products});
}

class ShopProduct {
  final String name;
  final double price;
  final String imageUrl;
  final String? description;
  final double? rating;
  final String? tag;
  final dynamic count;
  ShopProduct(
      {required this.name,
      required this.price,
      required this.imageUrl,
      this.count,
      this.description,
      this.rating,
      this.tag});
}
