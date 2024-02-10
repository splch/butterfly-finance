import 'package:isar/isar.dart';

part 'net_worth.g.dart';

@Collection()
class NetWorth {
  Id id = Isar.autoIncrement;

  late DateTime date;
  late double totalAssets;
  late double totalLiabilities;

  double get netWorth => totalAssets - totalLiabilities;
}
