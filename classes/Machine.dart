class Machine {
  
  int _coffeeBeans = 500;  // начальный запас кофе в граммах
  int _milk = 1000;        // начальный запас молока в мл
  int _water = 2000;       // начальный запас воды в мл
  int _cash = 0;           // начальная выручка в рублях

  // Геттеры (для получения значений полей)
  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  // Сеттеры (для установки значений полей)
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
    // Для эспрессо нужно: 50 гр кофе, 100 мл воды
    return (_coffeeBeans >= 50) && (_water >= 100);
  }

  // Закрытый метод уменьшения ресурсов 
  void _subtractResources() {
    _coffeeBeans -= 50;  // расход кофе на эспрессо
    _water -= 100;       // расход воды на эспрессо
    _cash += 150;        // цена эспрессо 150 руб.
  }

  // Публичный метод приготовления кофе
  bool makingCoffee() {
    if (isAvailable()) {
      _subtractResources();
      return true;  // кофе успешно приготовлен
    } else {
      return false; // недостаточно ресурсов
    }
  }

  // Дополнительный метод для отображения состояния машины
  void printStatus() {
    print('\n=== Состояние кофемашины ===');
    print('Кофе: $_coffeeBeans гр');
    print('Молоко: $_milk мл');
    print('Вода: $_water мл');
    print('Выручка: $_cash руб.');
    print('============================\n');
  }
}