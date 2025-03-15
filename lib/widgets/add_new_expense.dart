import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key});
  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,       // Default selected date is today
      firstDate: firstDate,   // Earliest selectable date (1 year ago)
      lastDate: now,          // Latest selectable date (today)
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate; // Store the selected date
      });

    }
  }


  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      prefix: Text("IDR "), label: Text('Amount'),),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null ? "dd/mm/yy" : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _openDatePicker,
                      icon: Icon(Icons.calendar_month_outlined))
                ],
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {
                print("Title: ${_titleController.text}");
                print("Selected Date: $_selectedDate"); // Debugging
              },
              child: Text("Save Expense"))
        ],
      ),
    );
  }
}
