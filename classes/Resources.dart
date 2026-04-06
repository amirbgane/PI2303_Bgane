import 'ICoffee.dart';

class Resources {
  int _coffeeBeans = 500;  // кофе в граммах
  int _milk = 1000;        // молоко в мл
  int _water = 2000;       // вода в мл
  int _cash = 0;           // выручка

  // Геттеры
  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  // Сеттеры
  set coffeeBeans(int value) {
    if (value >= 0) _coffeeBeans = value;
  }

  set milk(int value) {
    if (value >= 0) _milk = value;
  }

  set water(int value) {
    if (value >= 0) _water = value;
  }

  set cash(int value) {
    if (value >= 0) _cash = value;
  }

  // Проверка доступности ресурсов для конкретного кофе
  bool isAvailable(ICoffee coffee) {
    return (_coffeeBeans >= coffee.coffeeNeeded) &&
           (_water >= coffee.waterNeeded) &&
           (_milk >= coffee.milkNeeded);
  }

  // Списание ресурсов
  void subtractResources(ICoffee coffee) {
    _coffeeBeans -= coffee.coffeeNeeded;
    _water -= coffee.waterNeeded;
    _milk -= coffee.milkNeeded;
    _cash += coffee.price;
  }

  void printStatus() {
    print('\n=== Состояние кофемашины ===');
    print('Кофе: $_coffeeBeans гр');
    print('Молоко: $_milk мл');
    print('Вода: $_water мл');
    print('Выручка: $_cash руб.');
    print('============================\n');
  }
}