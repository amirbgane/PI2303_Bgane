class Machine {
  
  int _coffeeBeans = 500;  // начальный запас кофе в граммах
  int _milk = 1000;        // начальный запас молока в мл
  int _water = 2000;       // начальный запас воды в мл
  int _cash = 0;           // начальная выручка в рублях

  // Константы для рецепта эспрессо
  static const int ESPRESSO_COFFEE = 50;
  static const int ESPRESSO_WATER = 100;
  static const int ESPRESSO_PRICE = 150;

  // Геттеры
  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  // Сеттеры
  set coffeeBeans(int value) {
    if (value >= 0) {
      _coffeeBeans = value;
    }
  }

  set milk(int value) {
    if (value >= 0) {
      _milk = value;
    }
  }

  set water(int value) {
    if (value >= 0) {
      _water = value;
    }
  }

  set cash(int value) {
    if (value >= 0) {
      _cash = value;
    }
  }

  // Метод проверки доступности ресурсов для эспрессо
  bool isAvailable() {
    return (_coffeeBeans >= ESPRESSO_COFFEE) && (_water >= ESPRESSO_WATER);
  }

  // Закрытый метод уменьшения ресурсов 
  void _subtractResources() {
    _coffeeBeans -= ESPRESSO_COFFEE;
    _water -= ESPRESSO_WATER;
    _cash += ESPRESSO_PRICE;
  }

  // Публичный метод ,который только готовит кофе
  bool makeCoffee() {
    _subtractResources();
    return true;
  }

  // отображение состояния машины
  void printStatus() {
    print('\n=== Состояние кофемашины ===');
    print('Кофе: $_coffeeBeans гр');
    print('Молоко: $_milk мл');
    print('Вода: $_water мл');
    print('Выручка: $_cash руб.');
    print('============================\n');
  }
}