import 'dart:async';
import 'ICoffee.dart';

class CoffeeMaker {
  
  // Метод нагрева воды (3 секунды)
  Future<void> heatWater(ICoffee coffee) async {
    print('🔥 Начинаем нагрев воды для ${coffee.name}...');
    await Future.delayed(Duration(seconds: 3));
    print(' Вода нагрета до 90°C (3 сек)');
  }
  
  // Метод заваривания кофе (5 секунд)
  Future<void> brewCoffee(ICoffee coffee) async {
    print('☕ Начинаем заваривание ${coffee.name}...');
    await Future.delayed(Duration(seconds: 5));
    print(' Кофе заварен (5 сек)');
  }
  
  // Метод взбивания молока (5 секунд)
  Future<void> frothMilk(ICoffee coffee) async {
    if (coffee.milkNeeded > 0) {
      print('🥛 Начинаем взбивать молоко для ${coffee.name}...');
      await Future.delayed(Duration(seconds: 5));
      print(' Молоко взбито в пену (5 сек)');
    } else {
      print('🥛 Молоко не требуется для ${coffee.name}, пропускаем');
    }
  }
  
  // Метод смешивания кофе и молока (3 секунды)
  Future<void> mixCoffeeAndMilk(ICoffee coffee) async {
    if (coffee.milkNeeded > 0) {
      print('🔄 Смешиваем кофе с молоком для ${coffee.name}...');
      await Future.delayed(Duration(seconds: 3));
      print(' Кофе с молоком перемешан (3 сек)');
    } else {
      print('🔄 Смешивание не требуется для ${coffee.name}');
    }
  }
  
  // Главный метод приготовления (собирает всё вместе)
  Future<void> makeCoffeeAsync(ICoffee coffee) async {
    print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('☕ НАЧАЛО ПРИГОТОВЛЕНИЯ ${coffee.name.toUpperCase()}');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
    
    // Запускаем нагрев воды
    await heatWater(coffee);
    
    // Для кофе с молоком - запускаем параллельно заваривание и взбивание
    if (coffee.milkNeeded > 0) {
      print('\n--- Запускаем процессы параллельно ---');
      
      // Параллельное выполнение
      await Future.wait([
        brewCoffee(coffee),
        frothMilk(coffee),
      ]);
      
      print('\n--- Оба процесса завершены ---');
      
      // Смешиваем
      await mixCoffeeAndMilk(coffee);
      
    } else {
      // Для эспрессо (без молока) - только заваривание
      await brewCoffee(coffee);
    }
    
    print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print(' ${coffee.name} ГОТОВ! ');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  }
}