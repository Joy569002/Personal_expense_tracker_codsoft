import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomMessageCard extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController typeController;
  final VoidCallback onSubmit;

  const CustomMessageCard({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.typeController,
    required this.onSubmit,
  });

  @override
  _CustomMessageCardState createState() => _CustomMessageCardState();
}

class _CustomMessageCardState extends State<CustomMessageCard> {
  String? _selectedCategory;
  final List<String> _categories = ['Earn', 'Expense'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Add Expense Detail".text.bold.size(24).green400.make(),
          SizedBox(height: 16.0),
          TextField(
            controller: widget.titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              labelText: 'Enter title',
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
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
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              labelText: 'Select category',
              filled: true,
              fillColor: Colors.grey[200],
            ),
            value: _selectedCategory,
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
                widget.typeController.text = newValue!;
              });
            },
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
            child: "Submit".text.white.bold.make(),
          ),
        ],
      ).box.rounded.gray200.p16.make(),
    );
  }
}
