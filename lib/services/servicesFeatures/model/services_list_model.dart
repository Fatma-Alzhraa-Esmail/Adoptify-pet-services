class Category {
  final String id;
  final String name;
  final String imageUrl;
  final List<Product> products;

  Category(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.products});
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
 final String? description;
 final double? rating;
 final String? tag;
 final dynamic count;

  Product({required this.name, required this.price, required this.imageUrl,this.count,this.description,this.rating,this.tag});
}
