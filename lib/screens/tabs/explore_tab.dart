import 'package:flutter/material.dart';
import '../../data/food_data.dart';
import '../../models/food.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/food_card.dart';

class ExploreTab extends StatefulWidget {
  final Function(Food) onFoodTap;
  final Set<int> favorites;
  final Function(Food) onFavorite;

  const ExploreTab({
    super.key,
    required this.onFoodTap,
    required this.favorites,
    required this.onFavorite,
  });

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final controller = TextEditingController();
  String query = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = foodList.where((food) =>
    food.name.toLowerCase().contains(query.toLowerCase()) ||
        food.category.toLowerCase().contains(query.toLowerCase())
    ).toList();

    return SafeArea(
      child: Column(
        children: [
          appHeader(
            'Explore Food',
            subtitle: 'Find your favorite delicious food',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: controller,
              onChanged: (value) => setState(() => query = value),
              decoration: InputDecoration(
                hintText: 'Search food, category...',
                hintStyle: const TextStyle(color: muted, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: green),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                    setState(() => query = '');
                  },
                  icon: const Icon(Icons.close, color: muted),
                ),
                filled: true,
                fillColor: surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Popular Foods',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${results.length} items',
                  style: const TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: results.isEmpty
                ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_off, size: 55, color: muted),
                  SizedBox(height: 10),
                  Text('No food found'),
                ],
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: results.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 13,
                childAspectRatio: .78,
              ),
              itemBuilder: (_, i) {
                final food = results[i];
                return FoodCard(
                  food: food,
                  isFavorite: widget.favorites.contains(food.id),
                  onFavorite: () => widget.onFavorite(food),
                  onTap: () => widget.onFoodTap(food),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
