import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/user.dart';
import 'package:butterfly_finance/view_models/user_view_model.dart';

void main() {
  late DatabaseService databaseService;
  late Isar isar;

  setUp(() async {
    final directory = Directory.systemTemp.createTempSync();

    isar = await Isar.open(
      [UserSchema],
      directory: directory.path,
    );

    // Initialize the database service with the mock Isar instance
    databaseService = DatabaseService();
    databaseService.isar = isar;
  });

  tearDown(() async {
    await databaseService.closeDatabase(deleteFromDisk: true);
  });

  group('UserViewModel Tests', () {
    late UserViewModel userViewModel;

    setUp(() {
      // Initialize the UserViewModel with the DatabaseService
      userViewModel = UserViewModel(databaseService);
    });

    test('Add and Retrieve User', () async {
      final testUser = User()
        ..email = 'user@example.com'
        ..name = 'Test User'
        ..plaidClientId = '123'
        ..plaidSecret = '456';

      await userViewModel.addUser(testUser);
      final users = await userViewModel.getAllUsers();
      expect(users.isNotEmpty, true);
      expect(users.first.name, equals('Test User'));
    });
  });
}
