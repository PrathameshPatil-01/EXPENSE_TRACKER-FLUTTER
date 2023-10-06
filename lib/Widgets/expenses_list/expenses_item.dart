import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Text(expense.title),
          const SizedBox(height: 20,),
          Row(
            children: [
              Text('\$$expense.amount.toStringAsFixed(2)'),
              const Spacer(),
              Row(
                children: [
                  Icon(CategoryIcons[expense.category]),
                  const SizedBox(width: 8,),
                  Text(expense.formattedDate),
                ],
              ),
            ],
          )
        ],
      ),
    ),);
  }
}
