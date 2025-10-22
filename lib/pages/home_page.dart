import 'package:expense_tracker/widget/button.dart';
import 'package:expense_tracker/widget/transaction_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle taps here - works like a button press for each item
          switch (index) {
            case 0:
              print('Home tapped');
              break;
            case 1:
              print('Stats tapped');
              break;
            case 2:
              
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

          // App title
          const Center(
            child: Text(
              'Quick Budget Tracker',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Balance card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Text(
                  'Current Balance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '\$1,200.50',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  label: 'Add Income',
                  icon: Icons.add,
                  onPressed: () {},
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white),
              CustomButton(
                  label: 'Add Expense',
                  icon: Icons.remove,
                  onPressed: () {},
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white)
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Recent Transactions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          // Dummy Transactions List
          TransactionTile(
              title: 'Electricity Bill',
              amount: '-\$75.00',
              date: 'April 2, 2024',
              icon: Icons.flash_on,
              color: Colors.red),

          TransactionTile(
              title: 'Groceries',
              amount: '-\$50.00',
              date: 'April 3, 2024',
              icon: Icons.shopping_cart,
              color: Colors.red),
          TransactionTile(
              title: 'Salary',
              amount: '+\$2,000.00',
              date: 'April 4, 2024',
              icon: Icons.attach_money,
              color: Colors.green),
          TransactionTile(
              title: 'Coffee',
              amount: '-\$5.00',
              date: 'April 5, 2024',
              icon: Icons.local_cafe,
              color: Colors.red),
        ],
      ),
    );
  }
}
