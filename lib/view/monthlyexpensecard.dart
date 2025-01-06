import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Addmonthlyexpense extends StatefulWidget {
  final TextEditingController amountController;
  final VoidCallback onSubmit;

  const Addmonthlyexpense({
    super.key,
    required this.amountController,
    required this.onSubmit,
  });

  @override
  _AddmonthlyexpenseState createState() => _AddmonthlyexpenseState();
}

class _AddmonthlyexpenseState extends State<Addmonthlyexpense> {
  String? _selectedCategory;
  final List<String> _categories = ['Earn', 'Expense'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Add Monthly Budget".text.bold.size(24).green400.make(),
            SizedBox(height: 16.0),
            TextField(
              controller: widget.amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: 'Enter amount',
                filled: true,
                fillColor: Colors.grey[200],
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: widget.onSubmit,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                backgroundColor: Colors.purple, // Change button color to violet
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: "Submit".text.bold.white.make(),
            ),
          ],
        ).box.rounded.gray200.p16.make().centered(),
      ),
    );
  }
}
