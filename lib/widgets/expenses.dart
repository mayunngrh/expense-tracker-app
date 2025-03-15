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
  final List<Expense> expenseList = [
    Expense(
        title: "Groceries",
        amount: 50000,
        date: DateTime(2025, 3, 10),
        category: Category.food),
    Expense(
        title: "Electricity Bill",
        amount: 120000,
        date: DateTime(2025, 3, 5),
        category: Category.work),
    Expense(
        title: "Internet Subscription",
        amount: 300000,
        date: DateTime(2025, 3, 1),
        category: Category.work),
    Expense(
        title: "Dinner at Restaurant",
        amount: 150000,
        date: DateTime(2025, 3, 8),
        category: Category.food),
    Expense(
        title: "Gym Membership",
        amount: 250000,
        date: DateTime(2025, 3, 3),
        category: Category.leisure),
  ];

  void _addExpenseBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return AddNewExpense(addExpense: _addExpense,);
      },
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      expenseList.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: ExpensesList(expenses: expenseList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
