import 'package:isar/isar.dart';

part 'account.g.dart';

@Collection()
class Account {
  Id id = Isar.autoIncrement;

  late String accountId;
  late String accountName;
  late String accountType;
  late double balance;
}
