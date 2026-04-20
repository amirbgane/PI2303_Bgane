import 'package:flutter/material.dart';
import '../classes/Machine.dart';
import '../classes/ICoffee.dart';
import '../classes/Espresso.dart';
import '../classes/Cappuccino.dart';
import '../classes/Latte.dart';

class ControlScreen extends StatefulWidget {
  final Machine machine;
  final Function(String) showMessage;
  final Function(ICoffee) onCoffeeMade;
  
  const ControlScreen({
    Key? key,
    required this.machine,
    required this.showMessage,
    required this.onCoffeeMade,
  }) : super(key: key);
  
  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool _isMaking = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Приготовление'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Кнопки кофе
            ElevatedButton(
              onPressed: _isMaking ? null : () => _makeCoffee(Espresso()),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Эспрессо (150 руб.)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isMaking ? null : () => _makeCoffee(Cappuccino()),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Капучино (200 руб.)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isMaking ? null : () => _makeCoffee(Latte()),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Латте (220 руб.)'),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            // КНОПКА ПОПОЛНЕНИЯ РЕСУРСОВ
            ElevatedButton.icon(
              onPressed: _isMaking ? null : _showRefillDialog,
              icon: const Icon(Icons.add),
              label: const Text('Пополнить ресурсы'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
            if (_isMaking)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
  
  Future<void> _makeCoffee(ICoffee coffee) async {
    setState(() {
      _isMaking = true;
    });
    
    if (!widget.machine.canMake(coffee)) {
      widget.showMessage('❌ Недостаточно ресурсов для ${coffee.name}!');
      setState(() {
        _isMaking = false;
      });
      return;
    }
    
    widget.showMessage('☕ Начинаем приготовление ${coffee.name}...');
    
    await widget.machine.makeCoffeeAsync(coffee, onMessage: (msg) {
      widget.showMessage(msg);
    });
    
    widget.showMessage('✅ ${coffee.name} готов! Приятного аппетита!');
    
    widget.onCoffeeMade(coffee);
    
    setState(() {
      _isMaking = false;
    });
  }
  
  // Диалог пополнения ресурсов
  void _showRefillDialog() {
    int addCoffee = 0;
    int addWater = 0;
    int addMilk = 0;
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Пополнение ресурсов'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRefillField(
                label: 'Кофе (гр)',
                onChanged: (val) => addCoffee = val,
              ),
              const SizedBox(height: 12),
              _buildRefillField(
                label: 'Вода (мл)',
                onChanged: (val) => addWater = val,
              ),
              const SizedBox(height: 12),
              _buildRefillField(
                label: 'Молоко (мл)',
                onChanged: (val) => addMilk = val,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.machine.resources.coffeeBeans += addCoffee;
                widget.machine.resources.water += addWater;
                widget.machine.resources.milk += addMilk;
                widget.showMessage('✅ Ресурсы пополнены!');
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Пополнить'),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildRefillField({
    required String label,
    required Function(int) onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label),
        ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'количество',
            ),
            onChanged: (value) {
              onChanged(int.tryParse(value) ?? 0);
            },
          ),
        ),
      ],
    );
  }
}