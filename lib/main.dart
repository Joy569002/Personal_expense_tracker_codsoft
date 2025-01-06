import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/controller/personal_expense_controller.dart';
import 'package:personal_expense_tracker/database/database.dart';
import 'package:personal_expense_tracker/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataClass().initdb();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ExpenseTracker(),
    );
  }
}
