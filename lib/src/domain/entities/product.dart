class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stock;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? stock,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }

  @override
  String toString() =>
      'Product(id: ' + id + ', name: ' + name + ', desc: ' + description + ', price: ' + price.toString() + ', stock: ' + stock.toString() + ')';
}
