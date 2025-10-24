// create this file
import 'package:expense_tracker/pages/stats_page.dart';
import 'package:expense_tracker/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widget/button.dart';
import 'package:expense_tracker/widget/transaction_tile.dart';
import 'package:expense_tracker/pages/Common_page.dart';
import 'package:expense_tracker/pages/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<TransactionModel> transactions = [
      TransactionModel(category: 'Electricity', amount: 75, isIncome: false),
      TransactionModel(category: 'Groceries', amount: 50, isIncome: false),
      TransactionModel(category: 'Salary', amount: 2000, isIncome: true),
      TransactionModel(category: 'Coffee', amount: 5, isIncome: false),
    ];

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
            child: const Column(
              children: [
                Text('Current Balance',
                    style: TextStyle(color: Colors.white70, fontSize: 16)),
                SizedBox(height: 8),
                Text('\$1,200.50',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommonPage(
                        appbartitle: 'Income',
                        title: 'Income',
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              CustomButton(
                label: 'Add Expense',
                icon: Icons.remove,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommonPage(
                        appbartitle: 'Expense',
                        title: 'Expense',
                      ),
                    ),
                  );
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
              date: 'April 2024',
              icon: t.isIncome ? Icons.arrow_upward : Icons.arrow_downward,
              color: t.isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
