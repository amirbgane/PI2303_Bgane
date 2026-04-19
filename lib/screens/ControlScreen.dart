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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isMaking ? null : () => _makeCoffee(Espresso()),
              child: const Text('Эспрессо (150 руб.)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isMaking ? null : () => _makeCoffee(Cappuccino()),
              child: const Text('Капучино (200 руб.)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isMaking ? null : () => _makeCoffee(Latte()),
              child: const Text('Латте (220 руб.)'),
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
    print('Нажата кнопка для ${coffee.name}'); // Отладка
    
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
    
    // ВАЖНО: Добавляем заказ в историю
    print('Вызываем onCoffeeMade для ${coffee.name}'); // Отладка
    widget.onCoffeeMade(coffee);
    
    setState(() {
      _isMaking = false;
    });
  }
}