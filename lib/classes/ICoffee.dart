// Абстрактный класс-интерфейс для всех видов кофе
abstract class ICoffee {
  int get coffeeNeeded;   // сколько кофе нужно
  int get milkNeeded;     // сколько молока нужно
  int get waterNeeded;    // сколько воды нужно
  int get price;          // цена
  String get name;        // название
}