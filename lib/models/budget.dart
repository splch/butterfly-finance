import 'package:isar/isar.dart';

part 'budget.g.dart';

@Collection()
class Budget {
  Id id = Isar.autoIncrement;

  late String budgetId;
  late String categoryId;
  late double amount;
}
