import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expense_card.dart';
import 'package:flutter/cupertino.dart';

class ExpensesList extends StatelessWidget{
  ExpensesList({required this.expenses,super.key});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenses.length ,itemBuilder: (context, index) => ExpenseCard(expense: expenses[index]));
  }
}