import 'Resources.dart';
import 'ICoffee.dart';

class Machine {
  final Resources _resources;
  
  Machine(this._resources);
  
  // Проверка, можно ли приготовить
  bool canMake(ICoffee coffee) {
    return _resources.isAvailable(coffee);
  }
  
  // Приготовление
  void makeCoffee(ICoffee coffee) {
    _resources.subtractResources(coffee);
  }
  
  Resources get resources => _resources;
}