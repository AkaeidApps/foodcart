import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class CheckoutDialog extends StatelessWidget {
  final double total;
  final VoidCallback onConfirm;

  const CheckoutDialog({
    super.key,
    required this.total,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: const Text(
        'Confirm Your Order',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your food is ready to order.',
            style: TextStyle(color: muted),
          ),
          const SizedBox(height: 20),
          priceRow('Subtotal', money(total)),
          const SizedBox(height: 10),
          priceRow('Delivery Fee', '৳50'),
          const Divider(height: 25),
          priceRow('Total', money(total + 50), bold: true),
          const SizedBox(height: 18),
          const Text(
            'Payment Method',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.payments_outlined, color: green),
              SizedBox(width: 8),
              Text('Cash on Delivery'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: muted),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: green,
          ),
          child: const Text('Confirm Order'),
        ),
      ],
    );
  }
}
