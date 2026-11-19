import 'package:flutter/material.dart';
import '../models/food.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class DetailScreen extends StatefulWidget {
  final Food food;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final Function(int) onAddToCart;

  const DetailScreen({
    super.key,
    required this.food,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAddToCart,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  bool delivery = true;
  bool coupon = false;

  @override
  Widget build(BuildContext context) {
    final total = widget.food.price * quantity;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              child: Row(
                children: [
                  iconCircle(
                    Icons.arrow_back,
                        () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Food Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  iconCircle(
                    widget.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    widget.onFavorite,
                    color: widget.isFavorite
                        ? Colors.redAccent
                        : Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'food_${widget.food.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: foodImage(
                          widget.food.image,
                          height: 240,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 17,
                        ),
                        const SizedBox(width: 5),
                        Text('${widget.food.rating}'),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.access_time,
                          color: muted,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.food.time,
                          style: const TextStyle(color: muted),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.local_fire_department,
                          color: muted,
                          size: 16,
                        ),
                        Text(
                          '${widget.food.calories} kcal',
                          style: const TextStyle(color: muted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      widget.food.description,
                      style: const TextStyle(
                        color: muted,
                        height: 1.6,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Delivery Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: selectButton(
                            'Delivery',
                            delivery,
                                () => setState(() => delivery = true),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: selectButton(
                            'Pick Up',
                            !delivery,
                                () => setState(() => delivery = false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Coupon',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => setState(() => coupon = !coupon),
                      child: Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          coupon ? 'Coupon Applied ✓' : 'Add Coupon +',
                          style: const TextStyle(
                            color: green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Order Quantity',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        smallButton(
                          Icons.remove,
                              () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                        smallButton(
                          Icons.add,
                              () => setState(() => quantity++),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(17),
              decoration: const BoxDecoration(
                color: surface,
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(color: muted, fontSize: 11),
                        ),
                        Text(
                          money(total),
                          style: const TextStyle(
                            fontSize: 22,
                            color: green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 49,
                    width: 175,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.onAddToCart(quantity);
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 19,
                      ),
                      label: const Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectButton(
      String title,
      bool active,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? green : surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
