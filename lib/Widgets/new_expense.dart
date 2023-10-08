import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return NewExpenseState();
  }
}

class NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: Text(
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            'Invalid Input'),
          content: const Text(
              'Please make sure valid title, amount, date and category was entered '),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
                ),
                  'Okay')
                  )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text.toUpperCase(),
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if(width>=600) Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  Expanded(
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                    controller: _titleController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      label: Text(
                        style: Theme.of(context).textTheme.titleMedium,
                        'Title'),
                    ),
                   ),
                  ),
                  const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      prefixText: 'Rs.',
                      label: Text(
                      style: Theme.of(context).textTheme.titleMedium!,
                        'Amount'),
                    ),
                  ),
                ),
                ],)
                else
                Column(
                  children: [
                    TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
                  controller: _titleController,
                  maxLength: 30,
                  decoration: InputDecoration(
                    label: Text(
                      style: Theme.of(context).textTheme.titleMedium!,
                      'Title'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  maxLength: 30,
                  decoration: InputDecoration(
                    prefixStyle: Theme.of(context).textTheme.bodyMedium,
                    prefixText: 'Rs.',
                    label: Text(
                      style: Theme.of(context).textTheme.titleMedium!,
                      'Amount'),
                  ),
                ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton(
                      dropdownColor: Theme.of(context).colorScheme.primary,
                        style: Theme.of(context).textTheme.bodyMedium,
                        value: _selectedCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    category.name.toUpperCase(),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:  Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        'Cancel'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: _submitExpenseData,
                      child:  Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        'Submit'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
