import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database.dart';
import '../model.dart';

class ExpenseTrackerController extends GetxController {
  static ExpenseTrackerController get instance => Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController setMonthlyBudget = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController monthlybudget = TextEditingController();

  Rx<double> totalAmount = 0.0.obs;
  Rx<double> totalEarning = 0.0.obs;
  Rx<double> totalExpense = 0.0.obs;
  Rx<double> monthlyBudgetvalue = 0.0.obs;
  Rx<double> lastMonthSavings = 0.0.obs;

  final DataClass dataClass = DataClass();

  RxList<Crudmodel> datalist = <Crudmodel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getdatalist();
    loadData();
  }

  void setBudget() {
    monthlyBudgetvalue.value = double.parse(monthlybudget.text);
    saveData();
    Get.back();
  }

  getdatalist() async {
    datalist.value = await dataClass.readAll();
  }

  void addamount(double amount) async {
    await dataClass.create(Crudmodel(
      title: titleController.text,
      type: typeController.text,
      amount: (typeController.text.trim() == "Earn") ? amount : amount,
      date: DateTime.now().toIso8601String(),
    ));
    loadData();
    updateTotals();
    getdatalist();
    Get.back();
  }

  deletedatabase() async {
    await dataClass.deleteDatabase();
    resetForNewMonth();
    getdatalist();
  }

  gettotalamount() async {
    totalAmount.value = await dataClass.totalamount();
  }

  gettotalexpens() async {
    totalExpense.value = await dataClass.getTotalExpenses();
  }

  gettotalearning() async {
    totalExpense.value = await dataClass.getTotalEarnings();
  }

  void updateTotals() async {
    totalEarning.value = await dataClass.getTotalEarnings();
    totalExpense.value = await dataClass.getTotalExpenses();
    totalAmount.value = gettotalamount();
    calculateLastMonthSavings();
    getdatalist();
    saveData();
  }

  void calculateLastMonthSavings() {
    lastMonthSavings.value = monthlyBudgetvalue.value - totalExpense.value;
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    monthlyBudgetvalue.value = prefs.getDouble('monthlyBudget') ?? 0.0;
    updateTotals();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('monthlyBudget', monthlyBudgetvalue.value);
  }

  void resetForNewMonth() {
    totalEarning.value = 0.0;
    totalExpense.value = 0.0;
    totalAmount.value = 0.0;
    dataClass.deleteDatabase();
    getdatalist();
    calculateLastMonthSavings();
    saveData();
  }
}
