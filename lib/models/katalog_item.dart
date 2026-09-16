import 'package:flutter/material.dart';

class KatalogItem {
  final String name;
  final String category;
  final int price;
  final String description;
  final IconData icon;
  final Color pastelColor;

  const KatalogItem({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.icon,
    required this.pastelColor,
  });

  String get formattedPrice {
    final digits = price.toString();
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }

    return 'Rp $buffer';
  }
}
