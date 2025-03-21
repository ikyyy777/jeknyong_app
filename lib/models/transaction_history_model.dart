// ini hanya dummy model untuk menampilkan data transaksi

class TransactionHistory {
  final String icon;
  final String title;
  final String date;
  final String amount;
  final String time;
  final bool isDebit;

  TransactionHistory({
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.time,
    required this.isDebit,
  });
}