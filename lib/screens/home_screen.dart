import 'package:flutter/material.dart';

import '../models/katalog_item.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<KatalogItem> katalog = [
    KatalogItem(
      name: 'Kopi Susu Gula Aren',
      category: 'Minuman',
      price: 22000,
      description:
          'Espresso robusta dipadukan susu segar dan gula aren asli. Disajikan dingin dengan es batu, cocok untuk menemani aktivitas harian.',
      icon: Icons.local_cafe,
      pastelColor: Color(0xFFFDF6E3),
    ),
    KatalogItem(
      name: 'Butter Croissant',
      category: 'Roti',
      price: 28000,
      description:
          'Croissant klasik dengan 27 lapisan adonan yang dipanggang hingga renyah di luar dan lembut di dalam. Dibuat segar setiap pagi.',
      icon: Icons.bakery_dining,
      pastelColor: Color(0xFFFFF3E0),
    ),
    KatalogItem(
      name: 'Matcha Latte',
      category: 'Minuman',
      price: 30000,
      description:
          'Matcha premium grade dari Uji, Jepang, dikocok bersama susu hangat. Rasa pahit yang lembut berpadu manis yang seimbang.',
      icon: Icons.emoji_food_beverage,
      pastelColor: Color(0xFFE8F5E9),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: katalog.length,
        itemBuilder: (context, index) {
          final item = katalog[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: item.pastelColor,
                foregroundColor: Colors.black87,
                child: Icon(item.icon),
              ),
              title: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${item.category} • ${item.formattedPrice}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Stack Navigation: menumpuk Screen 2 di atas Screen 1.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
