import 'package:expense_tracker/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsPage extends StatelessWidget {
  final List<TransactionModel> transactions;

  const StatsPage({super.key, required this.transactions});

  // Calculate totals dynamically for each category
  Map<String, double> _calculateCategoryTotals() {
    final Map<String, double> totals = {};
    for (var tx in transactions) {
      totals[tx.category] = (totals[tx.category] ?? 0) + tx.amount;
    }
    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final categoryTotals = _calculateCategoryTotals();
    final totalAmount = categoryTotals.values.fold(0.0, (a, b) => a + b);

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
                const SizedBox(height: 30),

                // --- PIE CHART ---
                SizedBox(
                  height: 250,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 50,
                      startDegreeOffset: -90,
                      sections: categoryTotals.entries.map((entry) {
                        final category = entry.key;
                        final value = entry.value;
                        final percentage =
                            totalAmount == 0 ? 0 : (value / totalAmount) * 100;
                        final color = colors[
                            categoryTotals.keys.toList().indexOf(category) %
                                colors.length];

                        return PieChartSectionData(
                          color: color,
                          value: value,
                          radius: 70,
                          title: percentage > 8
                              ? '${percentage.toStringAsFixed(1)}%'
                              : '', // Show only if big enough
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // --- LEGEND ---
                Expanded(
                  child: ListView.builder(
                    itemCount: categoryTotals.length,
                    itemBuilder: (context, index) {
                      final category = categoryTotals.keys.elementAt(index);
                      final value = categoryTotals[category]!;
                      final color = colors[index % colors.length];
                      final percentage =
                          totalAmount == 0 ? 0 : (value / totalAmount) * 100;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                category,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              '₹${value.toStringAsFixed(2)} '
                              '(${percentage.toStringAsFixed(1)}%)',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
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
