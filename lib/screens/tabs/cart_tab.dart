import 'package:flutter/material.dart';
import '../../data/food_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common_widgets.dart';

class CartTab extends StatelessWidget {
  final Map<int, int> cart;
  final double total;
  final Function(int, int) onUpdate;
  final VoidCallback onCheckout;

  const CartTab({
    super.key,
    required this.cart,
    required this.total,
    required this.onUpdate,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final ids = cart.keys.toList();

    return SafeArea(
      child: Column(
        children: [
          appHeader(
            'My Cart',
            subtitle: '${ids.length} different food items',
          ),
          Expanded(
            child: ids.isEmpty
                ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: green,
                    size: 65,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some delicious food!',
                    style: TextStyle(color: muted),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: ids.length,
              itemBuilder: (_, i) {
                final id = ids[i];
                final food = foodList.firstWhere((f) => f.id == id);
                final quantity = cart[id] ?? 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 13),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 85,
                          height: 85,
                          child: foodImage(food.image),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              money(food.price),
                              style: const TextStyle(
                                color: green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                smallButton(
                                  Icons.remove,
                                      () => onUpdate(id, quantity - 1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text('$quantity'),
                                ),
                                smallButton(
                                  Icons.add,
                                      () => onUpdate(id, quantity + 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => onUpdate(id, 0),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (ids.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  priceRow('Subtotal', money(total)),
                  const SizedBox(height: 10),
                  priceRow('Delivery Fee', '৳50'),
                  const Divider(height: 25, color: Colors.white12),
                  priceRow(
                    'Total',
                    money(total + 50),
                    bold: true,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onCheckout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Proceed to Checkout',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
