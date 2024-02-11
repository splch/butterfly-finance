import 'package:isar/isar.dart';

part 'budget.g.dart';

@Collection()
class Budget {
  Id id = Isar.autoIncrement;

  late String category;
  late double amount;
}
