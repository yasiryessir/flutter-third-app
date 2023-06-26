import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {
  food(Icons.lunch_dining),
  travel(Icons.flight_takeoff),
  leisure(Icons.movie),
  work(Icons.work);

  const Category(this.iconData);

  final IconData iconData;
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;

  final Category category;

  IconData get iconData {
    return category.iconData;
  }

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0.0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
