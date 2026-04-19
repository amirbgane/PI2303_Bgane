import 'Resources.dart';
import 'ICoffee.dart';
import 'CoffeeMaker.dart';

class Machine {
  final Resources _resources;
  final CoffeeMaker _coffeeMaker;
  
  Machine(this._resources) : _coffeeMaker = CoffeeMaker();
  
  bool canMake(ICoffee coffee) {
    return _resources.isAvailable(coffee);
  }
  
  Future<void> makeCoffeeAsync(ICoffee coffee, {Function(String)? onMessage}) async {
    if (!canMake(coffee)) {
      onMessage?.call('❌ Недостаточно ресурсов для ${coffee.name}!');
      return;
    }
    
    if (onMessage != null) {
      await _coffeeMaker.makeCoffeeAsync(coffee, onMessage);
    } else {
      await _coffeeMaker.makeCoffeeAsync(coffee, print);
    }
    
    _resources.subtractResources(coffee);
    onMessage?.call('💰 Списано ресурсов: ${coffee.coffeeNeeded}гр кофе, ${coffee.waterNeeded}мл воды, ${coffee.milkNeeded}мл молока');
    onMessage?.call('💰 Добавлено в выручку: ${coffee.price} руб.');
  }
  
  Resources get resources => _resources;
}