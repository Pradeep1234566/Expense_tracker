import 'package:expense_tracker/pages/transaction_page.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart'; // For currency formatting

class StatsPage extends StatelessWidget {
  final List<TransactionModel> transactions;

  const StatsPage({super.key, required this.transactions});

  // Calculate totals dynamically for each category, only for expenses
  Map<String, double> _calculateCategoryTotals() {
    final Map<String, double> totals = {};
    for (var tx in transactions.where((t) => !t.isIncome)) {
      totals[tx.category] = (totals[tx.category] ?? 0) + tx.amount;
    }
    // Group small categories into "Other" (less than 5% of total)
    final totalAmount = totals.values.fold(0.0, (a, b) => a + b);
    final Map<String, double> finalTotals = {};
    double otherTotal = 0;
    for (var entry in totals.entries) {
      if (totalAmount > 0 && (entry.value / totalAmount) < 0.05) {
        otherTotal += entry.value;
      } else {
        finalTotals[entry.key] = entry.value;
      }
    }
    if (otherTotal > 0) {
      finalTotals['Other'] = otherTotal;
    }
    return finalTotals;
  }

  @override
  Widget build(BuildContext context) {
    final categoryTotals = _calculateCategoryTotals();
    final totalAmount = categoryTotals.values.fold(0.0, (a, b) => a + b);

    // Define colors for categories
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Expense Distribution',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Total Expenses
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Expenses:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(symbol: '₹', decimalDigits: 2)
                            .format(totalAmount),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // List of categories with progress bars
                Expanded(
                  child: categoryTotals.isEmpty
                      ? const Center(
                          child: Text(
                            'No expenses recorded.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: categoryTotals.length,
                          itemBuilder: (context, index) {
                            final category =
                                categoryTotals.keys.elementAt(index);
                            final value = categoryTotals[category]!;
                            final percentage =
                                totalAmount == 0 ? 0.0 : value / totalAmount;
                            final color = colors[index % colors.length];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          category,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${NumberFormat.currency(symbol: '₹', decimalDigits: 2).format(value)} (${(percentage * 100).toStringAsFixed(1)}%)',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  LinearProgressIndicator(
                                    value: percentage,
                                    backgroundColor: Colors.grey[300],
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(color),
                                    minHeight: 8,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
