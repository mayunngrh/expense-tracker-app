import 'package:expense_tracker_app/widgets/add_new_expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expenses> {
  Widget? mainContent;

  final List<Expense> expenseList = [];

  void _addExpenseBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return AddNewExpense(
          addExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      expenseList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    var expenseIndex = expenseList.indexOf(expense);
    setState(() {
      expenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenseList.insert(expenseIndex, expense);
            });
          }),
      content: const Text("Expense deleted."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (expenseList.isNotEmpty) {
      setState(() {
        mainContent = ExpensesList(
          expenses: expenseList,
          onRemovedExpanse: _removeExpense,
        );
      });
    } else {
      setState(() {
        mainContent = const Center(
          child: Expanded(child: Text("No Expense Found, start add some")),
        );
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Expenses Tracker App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white), // Add icon
            onPressed: _addExpenseBottomSheet,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 6),
          // Optional inner padding
          child: Column(
            children: [
              Text("Expense Chart"),
              const SizedBox(height: 16),
              Expanded(
                child: mainContent!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
