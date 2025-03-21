import 'package:flutter/material.dart';
import 'package:jeknyong_app/models/transaction_history_model.dart';

class HomeController extends ChangeNotifier {
  final List<String> infoJeknyongBanner = [
    "assets/images/banner1.png",
    "assets/images/banner1.png",
  ];

  final List<TransactionHistory> transactionHistory = [
    TransactionHistory(
      icon: "assets/icons/tarik_saldo.svg",
      title: "Tarik Saldo",
      date: "10 Januari 2024",
      amount: "55.000",
      time: "10:21",
      isDebit: true,
    ),
    TransactionHistory(
      icon: "assets/icons/jual_sampah.svg",
      title: "Jual Sampah",
      date: "9 Januari 2024",
      amount: "75.000",
      time: "15:30",
      isDebit: false,
    ),
    TransactionHistory(
      icon: "assets/icons/tarik_saldo.svg",
      title: "Tarik Saldo",
      date: "8 Januari 2024",
      amount: "100.000",
      time: "09:15",
      isDebit: true,
    ),
    TransactionHistory(
      icon: "assets/icons/jual_sampah.svg",
      title: "Jual Sampah",
      date: "7 Januari 2024",
      amount: "125.000",
      time: "14:45",
      isDebit: false,
    ),
  ];
}
