import 'dart:io';
import 'Resources.dart';
import 'ICoffee.dart';
import 'Espresso.dart';
import 'Cappuccino.dart';
import 'Latte.dart';
import 'Machine.dart';

void main() {
  final resources = Resources();
  final machine = Machine(resources);
  
  print('=== Добро пожаловать в программу Кофемашина ===');
  
  bool isWorking = true;
  
  while (isWorking) {
    resources.printStatus();
    displayMenu();
    
    String? choice = stdin.readLineSync();
    isWorking = processChoice(choice, machine);
    
    if (isWorking) {
      print('\nНажмите Enter для продолжения...');
      stdin.readLineSync();
    }
  }
  
  print('Программа завершена.');
}

void displayMenu() {
  print('\nВыберите действие:');
  print('1. Эспрессо (150 руб.)');
  print('2. Капучино (200 руб.)');
  print('3. Латте (220 руб.)');
  print('4. Пополнить ресурсы');
  print('0. Выйти');
  stdout.write('Ваш выбор: ');
}

bool processChoice(String? choice, Machine machine) {
  switch (choice) {
    case '1':
      return makeCoffee(machine, Espresso());
    case '2':
      return makeCoffee(machine, Cappuccino());
    case '3':
      return makeCoffee(machine, Latte());
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

bool makeCoffee(Machine machine, ICoffee coffee) {
  print('\n--- Приготовление ${coffee.name} ---');
  
  if (!machine.canMake(coffee)) {
    print(' Недостаточно ресурсов!');
    print('Требуется:');
    print('  Кофе: ${coffee.coffeeNeeded} гр');
    print('  Вода: ${coffee.waterNeeded} мл');
    if (coffee.milkNeeded > 0) {
      print('  Молоко: ${coffee.milkNeeded} мл');
    }
    return true;
  }
  
  machine.makeCoffee(coffee);
  print(' ${coffee.name} готов!');
  print('Списано: ${coffee.coffeeNeeded} гр кофе, ${coffee.waterNeeded} мл воды',);
  if (coffee.milkNeeded > 0) {
    print(', ${coffee.milkNeeded} мл молока');
  } else {
    print('');
  }
  print('Добавлено в выручку: ${coffee.price} руб.');
  
  return true;
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

int readInt(String prompt) {
  stdout.write(prompt);
  try {
    return int.parse(stdin.readLineSync() ?? '0');
  } catch (e) {
    print('Ошибка ввода. Будет 0');
    return 0;
  }
}