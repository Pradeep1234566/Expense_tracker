import 'package:expense_tracker/pages/transaction_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Database {
  final Box<TransactionModel> box =
      Hive.box<TransactionModel>('transactionsBox');

  List<TransactionModel> getTransactions() {
    return box.values.toList();
  }

  void addTransaction(TransactionModel transaction) {
    box.add(transaction);
  }

  void deleteTransaction(int index) {
    box.deleteAt(index);
  }
}
