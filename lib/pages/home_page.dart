
import 'package:expense_tracker/pages/common_page.dart';
import 'package:expense_tracker/pages/settings_page.dart';
import 'package:expense_tracker/pages/stats_page.dart';
import 'package:expense_tracker/pages/transaction_page.dart';
import 'package:expense_tracker/widget/button.dart';
import 'package:expense_tracker/widget/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initialize with an empty list instead of dummy data
  final List<TransactionModel> transactions = [];

  // Calculate current balance
  double get currentBalance {
    double balance = 0.0;
    for (var transaction in transactions) {
      balance += transaction.isIncome
          ? transaction.amount
          : -transaction.amount;
    }
    return balance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              print('Home tapped');
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatsPage(transactions: transactions),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Stats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 30),
          const Center(
            child: Text(
              'Quick Budget Tracker',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text('Current Balance',
                    style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  '\$${currentBalance.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                label: 'Add Income',
                icon: Icons.add,
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommonPage(
                        appbartitle: 'Income',
                        title: 'Income',
                      ),
                    ),
                  );
                  if (result != null && result is TransactionModel) {
                    setState(() {
                      transactions.add(result);
                    });
                  }
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              CustomButton(
                label: 'Add Expense',
                icon: Icons.remove,
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommonPage(
                        appbartitle: 'Expense',
                        title: 'Expense',
                      ),
                    ),
                  );
                  if (result != null && result is TransactionModel) {
                    setState(() {
                      transactions.add(result);
                    });
                  }
                },
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text('Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...transactions.map(
            (t) => TransactionTile(
              title: t.category,
              amount:
                  '${t.isIncome ? '+' : '-'}\$${t.amount.toStringAsFixed(2)}',
              date: DateFormat('MMMM yyyy').format(t.date),
              icon: t.isIncome ? Icons.arrow_upward : Icons.arrow_downward,
              color: t.isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}