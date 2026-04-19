import 'package:flutter/material.dart';
import '../classes/ICoffee.dart';

class HistoryScreenController {
  final _HistoryScreenState state;
  
  HistoryScreenController(this.state);
  
  void addOrder(ICoffee coffee) {
    print('Controller addOrder вызван для ${coffee.name}');
    state.addOrder(coffee);
  }
}

class HistoryScreen extends StatefulWidget {
  final Function(HistoryScreenController)? onHistoryCreated;
  
  const HistoryScreen({Key? key, this.onHistoryCreated}) : super(key: key);
  
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> _orders = [];
  
  @override
  void initState() {
    super.initState();
    print('HistoryScreen initState');
    // Небольшая задержка для уверенности
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onHistoryCreated != null) {
        widget.onHistoryCreated!(HistoryScreenController(this));
      }
    });
  }
  
  void addOrder(ICoffee coffee) {
    print('addOrder вызван для ${coffee.name}');
    print('Текущее количество заказов: ${_orders.length}');
    setState(() {
      _orders.insert(0, {
        'name': coffee.name,
        'price': coffee.price,
        'time': DateTime.now(),
      });
    });
    print('Новое количество заказов: ${_orders.length}');
  }
  
  @override
  Widget build(BuildContext context) {
    print('HistoryScreen build, заказов: ${_orders.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('История заказов'),
        backgroundColor: Colors.green,
      ),
      body: _orders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'История заказов пуста',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Приготовьте первый кофе!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(order['name']),
                    subtitle: Text('${order['price']} руб.'),
                    trailing: Text(
                      _formatTime(order['time']),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
    );
  }
  
  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}