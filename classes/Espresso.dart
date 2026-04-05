import 'ICoffee.dart';

class Espresso implements ICoffee {
  @override
  int get coffeeNeeded => 50;
  
  @override
  int get milkNeeded => 0;
  
  @override
  int get waterNeeded => 100;
  
  @override
  int get price => 150;
  
  @override
  String get name => 'Эспрессо';
}