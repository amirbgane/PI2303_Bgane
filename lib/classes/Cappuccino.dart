import 'ICoffee.dart';

class Cappuccino implements ICoffee {
  @override
  int get coffeeNeeded => 50;
  
  @override
  int get milkNeeded => 150;
  
  @override
  int get waterNeeded => 100;
  
  @override
  int get price => 200;
  
  @override
  String get name => 'Капучино';
}