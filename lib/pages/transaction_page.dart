import 'package:flutter/material.dart';

class TransactionModel {
  final String category;
  final double amount;
  final bool isIncome;

  TransactionModel({
    required this.category,
    required this.amount,
    required this.isIncome,
  });
}
