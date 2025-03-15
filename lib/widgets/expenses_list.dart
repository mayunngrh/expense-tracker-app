import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expense_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList(
      {required this.expenses, required this.onRemovedExpanse, super.key});

  final List<Expense> expenses;
  final Function(Expense expense) onRemovedExpanse;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
            onDismissed: (direction) {
              onRemovedExpanse(expenses[index]);
            },
            background: Container(
              color: Color.fromARGB(125, 234, 76, 76),
            ),
            key: ValueKey(expenses[index]),
            child: ExpenseCard(expense: expenses[index])));
  }
}
