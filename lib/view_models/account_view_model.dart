import 'package:flutter/foundation.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/services/database_service.dart';

class AccountViewModel with ChangeNotifier {
  final DatabaseService _databaseService;

  AccountViewModel(this._databaseService);

  Future<void> addAccount(Account account) async {
    await _databaseService.addAccount(account);
    notifyListeners();
  }

  Future<List<Account>> getAllAccounts() async {
    return _databaseService.getAllAccounts();
  }

  Future<void> updateAccount(Account account) async {
    await _databaseService.updateAccount(account);
    notifyListeners();
  }

  Future<void> deleteAccount(int id) async {
    await _databaseService.deleteAccount(id);
    notifyListeners();
  }
}
