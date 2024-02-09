class Transaction {
  String transactionId;
  String accountId;
  DateTime date;
  double amount;
  String category;
  String description;

  Transaction({
    required this.transactionId,
    required this.accountId,
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
  });
}
