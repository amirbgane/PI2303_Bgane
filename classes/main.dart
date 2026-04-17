import 'dart:io';
import 'Resources.dart';
import 'ICoffee.dart';
import 'Espresso.dart';
import 'Cappuccino.dart';
import 'Latte.dart';
import 'Machine.dart';

void main() async {  // ← добавили async
  final resources = Resources();
  final machine = Machine(resources);
  
  print('=== Добро пожаловать в программу Кофемашина ===');
  print('=== (Асинхронное приготовление с выводом сообщений) ===\n');
  
  bool isWorking = true;
  
  while (isWorking) {
    resources.printStatus();
    displayMenu();
    
    String? choice = stdin.readLineSync();
    isWorking = await processChoice(choice, machine);  // ← добавили await
    
    if (isWorking) {
      print('\nНажмите Enter для продолжения...');
      stdin.readLineSync();
    }
  }
  
  print('Программа завершена. Итоговая выручка: ${resources.cash} руб.');
}

void displayMenu() {
  print('\nВыберите действие:');
  print('1. Эспрессо (150 руб.) - с выводом процесса');
  print('2. Капучино (200 руб.) - с выводом процесса');
  print('3. Латте (220 руб.) - с выводом процесса');
  print('4. Пополнить ресурсы');
  print('0. Выйти');
  stdout.write('Ваш выбор: ');
}

Future<bool> processChoice(String? choice, Machine machine) async {  // ← добавили async
  switch (choice) {
    case '1':
      await makeCoffeeAsync(machine, Espresso());  // ← новый метод
      return true;
    case '2':
      await makeCoffeeAsync(machine, Cappuccino());
      return true;
    case '3':
      await makeCoffeeAsync(machine, Latte());
      return true;
    case '4':
      refillResources(machine.resources);
      return true;
    case '0':
      print('\nДо свидания!');
      return false;
    default:
      print('\n Неверный выбор.');
      return true;
  }
}

// асинхронное приготовление с выводом процесса
Future<void> makeCoffeeAsync(Machine machine, ICoffee coffee) async {
  print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('☕ ЗАКАЗ: ${coffee.name}');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  
  await machine.makeCoffeeAsync(coffee);
  
  print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('🍽️ Приятного аппетита!');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
}

void refillResources(Resources resources) {
  print('\n--- Пополнение ресурсов ---');
  
  int addCoffee = readInt('Сколько кофе добавить (гр)? ');
  int addWater = readInt('Сколько воды добавить (мл)? ');
  int addMilk = readInt('Сколько молока добавить (мл)? ');
  
  resources.coffeeBeans = resources.coffeeBeans + addCoffee;
  resources.water = resources.water + addWater;
  resources.milk = resources.milk + addMilk;
  
  print('\n Ресурсы пополнены!');
}
Future<void> makeCoffeeWithFactory(Resources resources, ICoffee coffee) async {
  print('\n--- Используем Фабричный конструктор ---');
  // Фабричный конструктор сам запускает процесс
  Machine.makeCoffeeAsync(resources, coffee);
  // Даем время на выполнение
  await Future.delayed(Duration(seconds: 16));
}

int readInt(String prompt) {
  stdout.write(prompt);
  try {
    return int.parse(stdin.readLineSync() ?? '0');
  } catch (e) {
    print(' Ошибка ввода. Будет 0');
    return 0;
  }
}