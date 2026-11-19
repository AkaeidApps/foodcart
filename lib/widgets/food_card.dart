import 'package:flutter/material.dart';
import '../models/food.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class FoodCard extends StatefulWidget {
  final Food food;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  const FoodCard({
    super.key,
    required this.food,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'food_${widget.food.id}',
                      child: foodImage(widget.food.image),
                    ),
                    Positioned(
                      top: 9,
                      right: 9,
                      child: GestureDetector(
                        onTap: widget.onFavorite,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 33,
                          width: 33,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.6),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.isFavorite ? Colors.redAccent : Colors.white,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.food.time,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 3),
                        Text(
                          '${widget.food.rating}',
                          style: const TextStyle(fontSize: 11, color: muted),
                        ),
                        const Spacer(),
                        Text(
                          money(widget.food.price),
                          style: const TextStyle(
                            color: green,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
