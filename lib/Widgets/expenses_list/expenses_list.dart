import 'package:expense_tracker/Widgets/expenses_list/expenses_item.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
      // Dismissible(
      //   background: Container(
      //     margin: const EdgeInsets.all(15),
      //     color: const Color.fromARGB(255, 255, 0, 0),
      //   ),
      //   onDismissed: (direction) {
      //     onRemoveExpense(expenses[index]);
      //   },
      //   key: ValueKey(expenses[index]),
      //   child: ExpenseItem(expenses[index]),
      // ),
    );
  }
}
