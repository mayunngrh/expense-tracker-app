import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key, required this.addExpense});

  final Function(Expense expense) addExpense;

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: Text("INVALID INPUT"),
              content: Text("Please fill in all fields before submitting"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("ok"))
              ],
            ));
  }

  void submitData() {
    var isDataValid = true;
    if (_titleController.text != null &&
        _amountController.text != null &&
        _selectedDate != null &&
        _selectedCategory != null) {
      isDataValid = true;
    } else {
      isDataValid = false;
    }

    if (isDataValid) {
      widget.addExpense(Expense(title: _titleController.text,
          amount: int.parse(_amountController.text),
          date: _selectedDate!,
          category: _selectedCategory!));
      Navigator.pop(context);
    } else {
      _showAlertDialog();
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
                    prefix: Text("IDR "),
                    label: Text('Amount'),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? "dd/mm/yy"
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _openDatePicker,
                      icon: Icon(Icons.calendar_month_outlined))
                ],
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                      ))),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple)),
                      onPressed: submitData,
                      child: Text(
                        "Save Expense",
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          )
        ],
      ),
    );
  }
}
