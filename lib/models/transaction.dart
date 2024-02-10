import 'package:isar/isar.dart';

part 'transaction.g.dart';

@Collection()
class Transaction {
  Id id = Isar.autoIncrement;

  late String transactionId;
  late String accountId;
  late DateTime date;
  late double amount;
  late String category;
  late String description;
}
