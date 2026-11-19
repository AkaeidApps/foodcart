class Food {
  final int id;
  final String name;
  final String category;
  final String image;
  final double price;
  final double rating;
  final String description;
  final int calories;
  final String time;

  const Food({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    required this.description,
    this.calories = 320,
    this.time = '20 min',
  });
}
