enum ProductType { car, accessory, merch }

class Product {
  final String id, name, category, subtitle, engine, fuel, acceleration;
  final ProductType type;
  final double price, rating;
  final int reviewCount;

  const Product(
    this.id,
    this.name,
    this.type,
    this.category,
    this.price, {
    this.subtitle = '',
    this.rating = 4.8,
    this.reviewCount = 124,
    this.engine = '',
    this.fuel = '',
    this.acceleration = '',
  });

  factory Product.fromMap(String id, Map<String, dynamic> m) => Product(
        id,
        m['name'] ?? '',
        ProductType.values.byName(m['type'] ?? 'car'),
        m['category'] ?? '',
        (m['price'] ?? 0).toDouble(),
        subtitle: m['subtitle'] ?? '',
        rating: (m['rating'] ?? 0).toDouble(),
        reviewCount: m['reviewCount'] ?? 0,
        engine: m['engine'] ?? '',
        fuel: m['fuel'] ?? '',
        acceleration: m['acceleration'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'type': type.name,
        'category': category,
        'price': price,
        'subtitle': subtitle,
        'rating': rating,
        'reviewCount': reviewCount,
        'engine': engine,
        'fuel': fuel,
        'acceleration': acceleration,
      };
}