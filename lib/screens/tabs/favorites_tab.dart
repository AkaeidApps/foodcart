import 'package:flutter/material.dart';
import '../../data/food_data.dart';
import '../../models/food.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/food_card.dart';

class FavoritesTab extends StatelessWidget {
  final Set<int> favorites;
  final Function(Food) onFavorite;
  final Function(Food) onFoodTap;

  const FavoritesTab({
    super.key,
    required this.favorites,
    required this.onFavorite,
    required this.onFoodTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = foodList
        .where((food) => favorites.contains(food.id))
        .toList();

    return SafeArea(
      child: Column(
        children: [
          appHeader(
            'My Favorites',
            subtitle: 'Your favorite delicious foods',
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 65,
                    color: green,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'No favorites yet!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Add food to your favorites.',
                    style: TextStyle(color: muted),
                  ),
                ],
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: items.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 13,
                childAspectRatio: .78,
              ),
              itemBuilder: (_, i) {
                final food = items[i];
                return FoodCard(
                  food: food,
                  isFavorite: true,
                  onFavorite: () => onFavorite(food),
                  onTap: () => onFoodTap(food),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
