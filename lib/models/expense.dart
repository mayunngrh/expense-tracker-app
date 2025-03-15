import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

var formatter = DateFormat.yMd();

enum Category { work, food, traveling, leisure }

var categoryIcons = {
  Category.work: Icons.work,
  Category.food: Icons.fastfood_rounded,
  Category.leisure: Icons.timer_outlined,
  Category.traveling: Icons.airplanemode_on
};

class Expense {
  static const _uuid = Uuid(); // Change to static const

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = _uuid.v4(); // Use static reference

  final String id;
  final String title;
  final int amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
