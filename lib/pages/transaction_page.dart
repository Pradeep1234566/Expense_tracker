class TransactionModel {
  final String category;
  final double amount;
  final bool isIncome;
  final DateTime date;

  TransactionModel({
    required this.category,
    required this.amount,
    required this.isIncome,
    required this.date,
  });
}