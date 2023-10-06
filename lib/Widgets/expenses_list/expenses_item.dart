import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 1,
          vertical: 1,
        ),
        child: Expanded(
          child: Column(
            children: [
              Text(expense.title),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Rs. ${expense.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(expense.formattedDate),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
