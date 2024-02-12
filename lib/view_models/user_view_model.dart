import 'package:flutter/foundation.dart';
import 'package:butterfly_finance/models/user.dart';
import 'package:butterfly_finance/services/database_service.dart';

class UserViewModel with ChangeNotifier {
  final DatabaseService _databaseService;

  UserViewModel(this._databaseService);

  Future<void> addUser(User user) async {
    await _databaseService.addUser(user);
    notifyListeners();
  }

  Future<List<User>> getAllUsers() async {
    return _databaseService.getAllUsers();
  }

  Future<void> updateUser(User user) async {
    await _databaseService.updateUser(user);
    notifyListeners();
  }

  Future<void> deleteUser(String email) async {
    await _databaseService.deleteUser(email);
    notifyListeners();
  }

  Future<User?> getUser(String email) async {
    return _databaseService.getUser(email);
  }
}
