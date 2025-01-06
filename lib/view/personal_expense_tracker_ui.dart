import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/view/monthlyexpensecard.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controller/personal_expense_controller.dart';

class PersonalExpenseTrackerContainer extends StatelessWidget {
  const PersonalExpenseTrackerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseController = Get.put(ExpenseTrackerController());
    final _iselevated = true.obs;

    return Obx(() {
      return AnimatedPhysicalModel(
        shape: BoxShape.rectangle,
        elevation: _iselevated.value ? 32.0 : 0.0,
        color: Colors.white,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(16.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage(
                  "assets/bg.png",
                ),
                fit: BoxFit.fill),
          ),
          alignment: Alignment.center,
          child: (_iselevated.value)
              ? Column(
                  children: [
                    "Total Amount: \$${expenseController.totalAmount.value}"
                        .text
                        .bold
                        .white
                        .size(16)
                        .make()
                        .centered(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Earnings: \$${expenseController.totalEarning.value}"
                            .text
                            .white
                            .bold
                            .size(18)
                            .make(),
                        10.widthBox,
                        "Expenses: \$${expenseController.totalExpense.value}"
                            .text
                            .white
                            .bold
                            .size(18)
                            .make(),
                      ],
                    ).paddingSymmetric(horizontal: 5),
                  ],
                ).paddingSymmetric(horizontal: 20, vertical: 20)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Monthly Budget: "
                        .text
                        .white
                        .bold
                        .size(18)
                        .make()
                        .centered(),
                    "\$${expenseController.monthlyBudgetvalue.value}"
                        .text
                        .white
                        .bold
                        .size(18)
                        .make()
                        .centered(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            "Reset".text.white.bold.make()
                          ],
                        )
                            .box
                            .make()
                            .p12()
                            .onTap(() => expenseController.resetForNewMonth()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            "Set Expense".text.white.bold.make()
                          ],
                        ).box.make().p12().onTap(() => Get.to(() =>
                            Addmonthlyexpense(
                                amountController:
                                    expenseController.monthlybudget,
                                onSubmit: expenseController.setBudget))),
                      ],
                    ),
                  ],
                )
                  .box
                  .width(double.infinity)
                  .border(color: Vx.sky100, width: 4)
                  .rounded
                  .padding(const EdgeInsets.all(4))
                  .make(),
        ).onTap(() {
          _iselevated.value = !_iselevated.value;
        }),
      );
    });
  }
}
