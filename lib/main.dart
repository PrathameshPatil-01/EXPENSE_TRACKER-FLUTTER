import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/app_theme.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: const Expenses(),
    ),
  );
}