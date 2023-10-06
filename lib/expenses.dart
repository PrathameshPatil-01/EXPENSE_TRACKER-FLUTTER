import 'package:expense_tracker/Widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  

  @override
  State<Expenses> createState() {
    return ExpensesState();
  }
}

class ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];
  void openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (builder) =>  NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EXPENSE_TRACKER"),
        actions: [
          IconButton(
            onPressed: openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(children: [
        Expanded(
          child: ExpensesList(expenses: _registeredExpenses,),
          ),
      ]),
    );
  }
}
