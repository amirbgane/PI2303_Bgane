import 'dart:io';
import 'Machine.dart';

void main() {
  // Создаем экземпляр кофемашины
  Machine myMachine = Machine();
  
  print('=== Добро пожаловать в программу Кофемашина ===');
  
  bool isWorking = true;
  
  while (isWorking) {
    // Выводим текущее состояние машины
    myMachine.printStatus();
    
    // Показываем меню пользователю (как на рисунке 2)
    print('Выберите действие:');
    print('1. Приготовить эспрессо');
    print('2. Пополнить ресурсы');
    print('0. Выйти');
    stdout.write('Ваш выбор: ');
    
    String? choice = stdin.readLineSync();
    
    switch (choice) {
      case '1':
        // Попытка приготовить кофе
        bool success = myMachine.makingCoffee();
        if (success) {
          print('\n Эспрессо готов! Приятного аппетита!');
          print('Списано: 50 гр кофе, 100 мл воды');
          print('Добавлено в выручку: 150 руб.\n');
        } else {
          print('\n Недостаточно ресурсов для приготовления эспрессо!');
          print('Требуется: 50 гр кофе, 100 мл воды\n');
        }
        break;
        
      case '2':
        // Пополнение ресурсов
        print('\n--- Пополнение ресурсов ---');
        stdout.write('Сколько кофе добавить (гр)? ');
        int addCoffee = int.parse(stdin.readLineSync() ?? '0');
        stdout.write('Сколько воды добавить (мл)? ');
        int addWater = int.parse(stdin.readLineSync() ?? '0');
        stdout.write('Сколько молока добавить (мл)? ');
        int addMilk = int.parse(stdin.readLineSync() ?? '0');
        
        // Используем сеттеры для добавления ресурсов
        myMachine.coffeeBeans = myMachine.coffeeBeans + addCoffee;
        myMachine.water = myMachine.water + addWater;
        myMachine.milk = myMachine.milk + addMilk;
        
        print('\n Ресурсы успешно пополнены!\n');
        break;
        
      case '0':
        print('\nЗавершение работы программы...');
        print('Итоговая выручка: ${myMachine.cash} руб.');
        isWorking = false;
        break;
        
      default:
        print('\n Неверный выбор. Попробуйте снова.\n');
    }
    
    if (isWorking) {
      print('Нажмите Enter для продолжения...');
      stdin.readLineSync();
    }
  }
  
  print('Программа завершена.');
}