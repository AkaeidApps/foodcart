import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/food.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'checkout_dialog.dart';
import 'detail_screen.dart';
import 'tabs/cart_tab.dart';
import 'tabs/explore_tab.dart';
import 'tabs/favorites_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/profile_tab.dart';

class MainScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const MainScreen({
    super.key,
    this.userName = 'Food Lover',
    this.userEmail = 'foodlover@example.com',
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final Set<int> favorites = {};
  final Map<int, int> cart = {};

  int get cartCount =>
      cart.values.fold(0, (total, quantity) => total + quantity);

  double get cartTotal {
    double total = 0;
    cart.forEach((id, quantity) {
      final food = foodList.firstWhere((f) => f.id == id);
      total += food.price * quantity;
    });
    return total;
  }

  void toggleFavorite(Food food) {
    setState(() {
      if (favorites.contains(food.id)) {
        favorites.remove(food.id);
      } else {
        favorites.add(food.id);
      }
    });
  }

  void addToCart(Food food, {int quantity = 1}) {
    setState(() {
      cart[food.id] = (cart[food.id] ?? 0) + quantity;
    });
    showMessage(context, '${food.name} added to cart');
  }

  void updateCart(int id, int quantity) {
    setState(() {
      if (quantity <= 0) {
        cart.remove(id);
      } else {
        cart[id] = quantity;
      }
    });
  }

  void openDetails(Food food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          food: food,
          isFavorite: favorites.contains(food.id),
          onFavorite: () => toggleFavorite(food),
          onAddToCart: (quantity) =>
              addToCart(food, quantity: quantity),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeTab(
        favorites: favorites,
        onFavorite: toggleFavorite,
        onFoodTap: openDetails,
      ),
      ExploreTab(
        onFoodTap: openDetails,
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
      FavoritesTab(
        favorites: favorites,
        onFavorite: toggleFavorite,
        onFoodTap: openDetails,
      ),
      CartTab(
        cart: cart,
        total: cartTotal,
        onUpdate: updateCart,
        onCheckout: () {
          if (cart.isEmpty) {
            showMessage(context, 'Your cart is empty');
            return;
          }
          showDialog(
            context: context,
            builder: (_) => CheckoutDialog(
              total: cartTotal,
              onConfirm: () {
                setState(() => cart.clear());
                Navigator.pop(context);
                showMessage(context, 'Order placed successfully!');
              },
            ),
          );
        },
      ),
      ProfileTab(
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF292929),
          border: Border(
            top: BorderSide(color: Colors.white10),
          ),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            height: 66,
            selectedIndex: selectedIndex,
            backgroundColor: const Color(0xFF292929),
            indicatorColor: green.withOpacity(.17),
            onDestinationSelected: (index) {
              setState(() => selectedIndex = index);
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: green),
                label: 'Home',
              ),
              const NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(Icons.explore, color: green),
                label: 'Explore',
              ),
              NavigationDestination(
                icon: Icon(
                  favorites.isNotEmpty
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                selectedIcon: const Icon(Icons.favorite, color: green),
                label: 'Favorite',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: const Icon(
                    Icons.shopping_bag,
                    color: green,
                  ),
                ),
                label: 'Cart',
              ),
              const NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: green),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
