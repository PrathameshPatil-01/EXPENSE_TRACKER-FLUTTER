import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData(),
      home: const Expenses(),
    ),
  );
}