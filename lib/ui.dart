import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/controller/personal_expense_controller.dart';
import 'package:personal_expense_tracker/view/expensecard.dart';
import 'package:personal_expense_tracker/view/personal_expense_tracker_ui.dart';
import 'package:personal_expense_tracker/widget/balancewidget.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ExpenseTrackerController expenseController =
        Get.put(ExpenseTrackerController());
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Expense Tracker").text.bold.black.make(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.to(() => Scaffold(
                appBar: AppBar(
                  title: Text("Add Expense").text.bold.black.make(),
                ),
                body: CustomMessageCard(
                  titleController: expenseController.titleController,
                  amountController: expenseController.amountController,
                  typeController: expenseController.typeController,
                  onSubmit: () => expenseController.addamount(
                      double.parse(expenseController.amountController.text)),
                ),
              )),
          label: Text('Add Expense'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        body: Column(
          children: [
            PersonalExpenseTrackerContainer()
                .paddingSymmetric(horizontal: 20, vertical: 20),
            40.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Earning/Expense")
                    .text
                    .bold
                    .red400
                    .size(24)
                    .make()
                    .paddingSymmetric(horizontal: 20),
              ],
            ),
            20.heightBox,
            Obx(
              () => Expanded(
                child: ListView.separated(
                  itemCount: expenseController.datalist.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return 20.heightBox;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var data = expenseController.datalist[index];
                    return BalanceLayout(
                      amount: data.amount,
                      title: data.title,
                      offsetAnimation: _offsetAnimation,
                      isexpense: data.type == "Expense" ? true : false,
                    ).box.width(double.infinity).make();
                  },
                ).paddingSymmetric(horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
