import 'dart:async';
import 'ICoffee.dart';

class CoffeeMaker {
  
  // Метод нагрева воды (3 секунды)
  Future<void> heatWater(ICoffee coffee, Function(String) onMessage) async {
    onMessage('🔥 Начинаем нагрев воды для ${coffee.name}...');
    await Future.delayed(const Duration(seconds: 3));
    onMessage('✅ Вода нагрета до 90°C');
  }
  
  // Метод заваривания кофе (5 секунд)
  Future<void> brewCoffee(ICoffee coffee, Function(String) onMessage) async {
    onMessage('☕ Начинаем заваривание ${coffee.name}...');
    await Future.delayed(const Duration(seconds: 5));
    onMessage('✅ Кофе заварен');
  }
  
  // Метод взбивания молока (5 секунд)
  Future<void> frothMilk(ICoffee coffee, Function(String) onMessage) async {
    if (coffee.milkNeeded > 0) {
      onMessage('🥛 Начинаем взбивать молоко для ${coffee.name}...');
      await Future.delayed(const Duration(seconds: 5));
      onMessage('✅ Молоко взбито в пену');
    } else {
      onMessage('🥛 Молоко не требуется для ${coffee.name}, пропускаем');
    }
  }
  
  // Метод смешивания кофе и молока (3 секунды)
  Future<void> mixCoffeeAndMilk(ICoffee coffee, Function(String) onMessage) async {
    if (coffee.milkNeeded > 0) {
      onMessage('🔄 Смешиваем кофе с молоком для ${coffee.name}...');
      await Future.delayed(const Duration(seconds: 3));
      onMessage('✅ Кофе с молоком перемешан');
    } else {
      onMessage('🔄 Смешивание не требуется для ${coffee.name}');
    }
  }
  
  // Главный метод приготовления (собирает всё вместе)
  Future<void> makeCoffeeAsync(ICoffee coffee, Function(String) onMessage) async {
    onMessage('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    onMessage('☕ НАЧАЛО ПРИГОТОВЛЕНИЯ ${coffee.name.toUpperCase()}');
    onMessage('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
    
    // Запускаем нагрев воды
    await heatWater(coffee, onMessage);
    
    // Для кофе с молоком - запускаем параллельно заваривание и взбивание
    if (coffee.milkNeeded > 0) {
      onMessage('\n--- Запускаем процессы параллельно ---');
      
      // Параллельное выполнение
      await Future.wait([
        brewCoffee(coffee, onMessage),
        frothMilk(coffee, onMessage),
      ]);
      
      onMessage('\n--- Оба процесса завершены ---');
      
      // Смешиваем
      await mixCoffeeAndMilk(coffee, onMessage);
      
    } else {
      // Для эспрессо (без молока) - только заваривание
      await brewCoffee(coffee, onMessage);
    }
    
    onMessage('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    onMessage('✨ ${coffee.name} ГОТОВ! ✨');
    onMessage('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  }
}