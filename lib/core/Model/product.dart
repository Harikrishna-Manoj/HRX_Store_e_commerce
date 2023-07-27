class Product {
  final String name;
  final String descrption;
  String? id;
  final int? price;
  final String? color;
  final String? size;
  final String? imageurl;
  final int? quantity;
  final String? category;

  Product(
      {required this.name,
      this.id,
      this.imageurl,
      this.price,
      this.color,
      this.size,
      this.quantity,
      this.category,
      this.descrption = ''});

  static Product fromJson(Map<String, dynamic> json) => Product(
      quantity: json['quantity'],
      imageurl: json['imageurl'],
      name: json['name'],
      descrption: json['description'],
      id: json['id'],
      color: json['color'],
      size: json['size'],
      price: json['price'],
      category: json['category']);

  Map<String, dynamic> toJason() => {
        'name': name,
        'discription': descrption,
        'id': id,
        'color': color,
        'size': size,
        'imageurl': imageurl,
        'category': category
      };
}

class WishlistProduct {
  final String name;
  String? id;
  final String? price;
  final String? imageurl;
  final String? category;

  WishlistProduct({
    required this.name,
    this.id,
    this.imageurl,
    this.price,
    this.category,
  });

  static WishlistProduct fromJson(Map<String, dynamic> json) => WishlistProduct(
      imageurl: json['imageurl'],
      name: json['name'],
      id: json['id'],
      price: json['price'],
      category: json['category']);

  Map<String, dynamic> toJason() => {
        'name': name,
        'id': id,
        'imageurl': imageurl,
        'category': category,
      };
}
