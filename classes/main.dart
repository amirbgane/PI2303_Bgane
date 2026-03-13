import 'dart:io';
import 'Machine.dart';

void main() {
  Machine myMachine = Machine();
  
  print('=== Добро пожаловать в программу Кофемашина ===');
  
  bool isWorking = true;
  
  while (isWorking) {
    myMachine.printStatus();
    displayMenu();
    
    String? choice = stdin.readLineSync();
    isWorking = processChoice(choice, myMachine);
    
    if (isWorking) {
      print('\nНажмите Enter для продолжения...');
      stdin.readLineSync();
    }
  }
  
  print('Программа завершена. Итоговая выручка: ${myMachine.cash} руб.');
}

// Функция отображения меню
void displayMenu() {
  print('\nВыберите действие:');
  print('1. Приготовить эспрессо');
  print('2. Пополнить ресурсы');
  print('0. Выйти');
  stdout.write('Ваш выбор: ');
}

// Функция обработки выбора пользователя
bool processChoice(String? choice, Machine machine) {
  switch (choice) {
    case '1':
      return makeEspresso(machine);
    case '2':
      refillResources(machine);
      return true;
    case '0':
      return exitProgram(machine);
    default:
      print('\n Неверный выбор. Попробуйте снова.');
      return true;
  }
}

// Функция приготовления эспрессо
bool makeEspresso(Machine machine) {
  print('\n--- Приготовление эспрессо ---');
  
  //Проверяем ресурсы
  if (!machine.isAvailable()) {
    print(' Недостаточно ресурсов!');
    print('Требуется: 50 гр кофе, 100 мл воды');
    return true;
  }
  
  //Готовим кофе
  machine.makeCoffee();
  print(' Эспрессо готов! Приятного аппетита!');
  print('Списано: 50 гр кофе, 100 мл воды');
  print('Добавлено в выручку: 150 руб.');
  
  return true;
}

// Функция пополнения ресурсов
void refillResources(Machine machine) {
  print('\n--- Пополнение ресурсов ---');
  
  int addCoffee = readInt('Сколько кофе добавить (гр)? ');
  int addWater = readInt('Сколько воды добавить (мл)? ');
  int addMilk = readInt('Сколько молока добавить (мл)? ');
  
  machine.coffeeBeans = machine.coffeeBeans + addCoffee;
  machine.water = machine.water + addWater;
  machine.milk = machine.milk + addMilk;
  
  print('\n Ресурсы успешно пополнены!');
}

// Функция выхода из программы
bool exitProgram(Machine machine) {
  print('\nЗавершение работы программы...');
  print('Итоговая выручка: ${machine.cash} руб.');
  return false;
}

// Вспомогательная функция для безопасного чтения чисел
int readInt(String prompt) {
  stdout.write(prompt);
  try {
    return int.parse(stdin.readLineSync() ?? '0');
  } catch (e) {
    print('Ошибка ввода. Будет использовано значение 0');
    return 0;
  }
}