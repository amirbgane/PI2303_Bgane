import 'Resources.dart';
import 'ICoffee.dart';
import 'CoffeeMaker.dart'; 

class Machine {
  final Resources _resources;
  final CoffeeMaker _coffeeMaker;
  
  // Обычный конструктор
  Machine(this._resources) : _coffeeMaker = CoffeeMaker();
  
  // Фабричный конструктор (создает машину и сразу делает кофе асинхронно)
  factory Machine.makeCoffeeAsync(Resources resources, ICoffee coffee) {
    final machine = Machine(resources);
    // Запускаем асинхронное приготовление (не ждем результата)
    machine._coffeeMaker.makeCoffeeAsync(coffee);
    return machine;
  }
  
  bool canMake(ICoffee coffee) {
    return _resources.isAvailable(coffee);
  }
  
  void makeCoffee(ICoffee coffee) {
    _resources.subtractResources(coffee);
  }
  
  // асинхронное приготовление с выводом сообщений
  Future<void> makeCoffeeAsync(ICoffee coffee) async {
    if (!canMake(coffee)) {
      print(' Недостаточно ресурсов для ${coffee.name}!');
      print('   Требуется: кофе ${coffee.coffeeNeeded}гр, вода ${coffee.waterNeeded}мл');
      if (coffee.milkNeeded > 0) {
        print('   Молоко: ${coffee.milkNeeded}мл');
      }
      return;
    }
    
    // Запускаем асинхронный процесс приготовления
    await _coffeeMaker.makeCoffeeAsync(coffee);
    
    // После приготовления списываем ресурсы
    _resources.subtractResources(coffee);
    print(' Списано ресурсов: ${coffee.coffeeNeeded}гр кофе, ${coffee.waterNeeded}мл воды', );
    if (coffee.milkNeeded > 0) {
      print(', ${coffee.milkNeeded}мл молока');
    } else {
      print('');
    }
    print(' Добавлено в выручку: ${coffee.price} руб.');
  }
  
  Resources get resources => _resources;
}