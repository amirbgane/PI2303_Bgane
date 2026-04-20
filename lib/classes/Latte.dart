import 'ICoffee.dart';

class Latte implements ICoffee {
  @override
  int get coffeeNeeded => 50;
  
  @override
  int get milkNeeded => 250;
  
  @override
  int get waterNeeded => 100;
  
  @override
  int get price => 220;
  
  @override
  String get name => 'Латте';
}