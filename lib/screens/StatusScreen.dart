import 'package:flutter/material.dart';
import '../classes/Resources.dart';

class StatusScreen extends StatelessWidget {
  final Resources resources;
  
  const StatusScreen({Key? key, required this.resources}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Состояние кофемашины'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildResourceRow(
                      icon: Icons.coffee,
                      label: 'Кофе в зернах',
                      value: resources.coffeeBeans,
                      unit: 'гр',
                      color: Colors.brown,
                    ),
                    const Divider(),
                    _buildResourceRow(
                      icon: Icons.water_drop,
                      label: 'Вода',
                      value: resources.water,
                      unit: 'мл',
                      color: Colors.blue,
                    ),
                    const Divider(),
                    _buildResourceRow(
                      icon: Icons.emoji_food_beverage,
                      label: 'Молоко',
                      value: resources.milk,
                      unit: 'мл',
                      color: Colors.white70,
                    ),
                    const Divider(),
                    _buildResourceRow(
                      icon: Icons.attach_money,
                      label: 'Выручка',
                      value: resources.cash,
                      unit: 'руб',
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildResourceRow({
    required IconData icon,
    required String label,
    required int value,
    required String unit,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(width: 20),
          Text(
            label,
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
          Text(
            '$value $unit',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}