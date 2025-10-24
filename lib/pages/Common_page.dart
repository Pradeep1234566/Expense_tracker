import 'package:expense_tracker/pages/transaction_page.dart';
import 'package:flutter/material.dart';
//import 'package:expense_tracker/models/transaction_model.dart'; // Import TransactionModel

class CommonPage extends StatefulWidget {
  final String appbartitle;
  final String title;

  const CommonPage({required this.appbartitle, required this.title, super.key});

  @override
  _CommonPageState createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    typeController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appbartitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                hintText: 'Enter ${widget.title} type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Enter ${widget.title} Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: selectedDate == null
                        ? 'Select Date'
                        : '${selectedDate!.toLocal()}'.split(' ')[0],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (typeController.text.isNotEmpty &&
                        amountController.text.isNotEmpty &&
                        selectedDate != null) {
                      final transaction = TransactionModel(
                        category: typeController.text,
                        amount: double.tryParse(amountController.text) ?? 0.0,
                        isIncome: widget.title.toLowerCase() == 'income',
                        date: selectedDate!,
                      );
                      Navigator.pop(context, transaction);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill all fields')),
                      );
                    }
                  },
                  child: Text('Save ${widget.title}'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}