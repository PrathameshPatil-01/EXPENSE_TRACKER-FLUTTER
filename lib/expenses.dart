import 'dart:convert';

import 'package:expense_tracker/Widgets/chart/chart.dart';
import 'package:expense_tracker/Widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return ExpensesState();
  }
}

class ExpensesState extends State<Expenses> {
  List<Expense> _registeredExpenses = [];
  var isLoading = true;
  String? _error;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (builder) => NewExpense(
        onPressed: _addExpense,
      ),
    );
  }

  void _loadItems() async {
    final url = Uri.https('expense-tracker-b8b43-default-rtdb.firebaseio.com',
        'expense_list.json');

    try {
      final response = await http.get(url);
      if (response.body == 'null') {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final listData = json.decode(response.body);
      final List<Expense> loadedItems = [];
      for (final item in listData.entries) {
        final category = Category.values
            .firstWhere((element) => element.name == item.value['category']);
        loadedItems.add(
          Expense(
            id: item.key,
            title: item.value['title'],
            amount: item.value['amount'],
            date: item.value['date'],
            category: category,
          ),
        );
      }
      setState(() {
        _registeredExpenses = loadedItems;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Something Went Wrong, Please try again later";
      });
    }
  }

  void _addExpense() async {
    _loadItems();
  }

  void _removeExpense(Expense expense) async {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    var isDelete = true;

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            textColor: Theme.of(context).colorScheme.primary,
            label: "Undo",
            onPressed: () {
              setState(() {
                isDelete = false;
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );

    Future.delayed(const Duration(seconds: 5), () async {
      if (isDelete) {
        final url = Uri.https(
            'expense-tracker-b8b43-default-rtdb.firebaseio.com',
            'expense_list/${expense.id}.json');
        var response = await http.delete(url);

        if (response.statusCode >= 400) {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(child: Text("No Expense Added Yet"));

    if (isLoading) {
      mainContent = const Center(child: CircularProgressIndicator());
    }

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    if (_error != null) {
      mainContent = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("EXPENSE_TRACKER"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(children: [
              Chart(expenses: _registeredExpenses),
              Expanded(
                child: mainContent,
              ),
            ])
          : Row(children: [
              Expanded(child: Chart(expenses: _registeredExpenses)),
              Expanded(
                child: mainContent,
              ),
            ]),
    );
  }
}
