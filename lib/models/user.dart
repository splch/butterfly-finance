import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;

  @Index(unique: true) // Ensures email is unique within the collection
  late String email;

  late String name;

  // Store Plaid keys
  late String plaidClientId;
  late String plaidSecret;
}
