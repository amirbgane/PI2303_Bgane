import 'package:flutter/material.dart';
import 'classes/Resources.dart';
import 'classes/Machine.dart';
import 'classes/ICoffee.dart';
import 'screens/StatusScreen.dart';
import 'screens/ControlScreen.dart';
import 'screens/HistoryScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const CoffeeMachineHomePage(),
    );
  }
}

class CoffeeMachineHomePage extends StatefulWidget {
  const CoffeeMachineHomePage({Key? key}) : super(key: key);
  
  @override
  State<CoffeeMachineHomePage> createState() => _CoffeeMachineHomePageState();
}

class _CoffeeMachineHomePageState extends State<CoffeeMachineHomePage> {
  late Resources _resources;
  late Machine _machine;
  HistoryScreenController? _historyController;  // ← СДЕЛАЛИ НЕ late, а nullable
  
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  
  @override
  void initState() {
    super.initState();
    _resources = Resources();
    _machine = Machine(_resources);
  }
  
  void _showMessage(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  void _onCoffeeMade(ICoffee coffee) {
    print('_onCoffeeMade вызван для ${coffee.name}');
    if (_historyController != null) {
      _historyController!.addOrder(coffee);
    } else {
      print('_historyController еще не инициализирован, сохраняем в буфер');
      // Сохраняем в буфер, если контроллер еще не готов
      _pendingOrder = coffee;
    }
    setState(() {});
  }
  
  ICoffee? _pendingOrder;  // Буфер для заказа, если история еще не готова
  
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.speed), text: 'Состояние'),
                  Tab(icon: Icon(Icons.coffee), text: 'Приготовление'),
                  Tab(icon: Icon(Icons.history), text: 'История'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StatusScreen(resources: _resources),
                    ControlScreen(
                      machine: _machine,
                      showMessage: _showMessage,
                      onCoffeeMade: _onCoffeeMade,
                    ),
                    HistoryScreen(
                      onHistoryCreated: (controller) {
                        print('HistoryScreen контроллер получен');
                        _historyController = controller;
                        // Если был отложенный заказ, добавляем его сейчас
                        if (_pendingOrder != null) {
                          print('Добавляем отложенный заказ: ${_pendingOrder!.name}');
                          _historyController!.addOrder(_pendingOrder!);
                          _pendingOrder = null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}