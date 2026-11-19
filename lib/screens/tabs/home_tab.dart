import 'package:flutter/material.dart';
import '../../data/food_data.dart';
import '../../models/food.dart';
import '../../theme/app_theme.dart';
import '../../widgets/food_card.dart';

class HomeTab extends StatefulWidget {
  final Set<int> favorites;
  final Function(Food) onFavorite;
  final Function(Food) onFoodTap;

  const HomeTab({
    super.key,
    required this.favorites,
    required this.onFavorite,
    required this.onFoodTap,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'All';

  final categories = [
    'All', 'Chicken', 'Pizza', 'Burger',
    'Pasta', 'Salad', 'Dessert', 'Drinks', 'Sushi', 'Tacos', 'Seafood'
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = foodList.where((food) =>
    selectedCategory == 'All' ||
        food.category == selectedCategory
    ).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: green,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deliver to',
                              style: TextStyle(
                                color: muted,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              'Dhaka, Bangladesh',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: surface2,
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(17),
                    height: 155,
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=900',
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SPECIAL OFFER',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'BUY 1\nGET 1 FREE',
                            style: TextStyle(
                              fontSize: 25,
                              height: 1.05,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Text(
                              'ORDER NOW',
                              style: TextStyle(
                                color: green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View all',
                          style: TextStyle(color: green),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 43,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final name = categories[i];
                        final active = selectedCategory == name;
                        return GestureDetector(
                          onTap: () => setState(
                                () => selectedCategory = name,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: active ? green : surface,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 23),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Special for you',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(Icons.tune, color: green),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final food = filtered[index];
                  return FoodCard(
                    food: food,
                    isFavorite: widget.favorites.contains(food.id),
                    onFavorite: () => widget.onFavorite(food),
                    onTap: () => widget.onFoodTap(food),
                  );
                },
                childCount: filtered.length,
              ),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 13,
                childAspectRatio: .78,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),
        ],
      ),
    );
  }
}
