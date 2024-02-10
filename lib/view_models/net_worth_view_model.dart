import 'package:flutter/foundation.dart';
import 'package:butterfly_finance/models/net_worth.dart';
import 'package:butterfly_finance/services/database_service.dart';

class NetWorthViewModel with ChangeNotifier {
  final DatabaseService _databaseService;

  NetWorthViewModel(this._databaseService);

  Future<void> addNetWorth(NetWorth netWorth) async {
    await _databaseService.addNetWorth(netWorth);
    notifyListeners();
  }

  Future<List<NetWorth>> getAllNetWorthRecords() async {
    return _databaseService.getAllNetWorthRecords();
  }

  Future<void> updateNetWorth(NetWorth netWorth) async {
    await _databaseService.updateNetWorth(netWorth);
    notifyListeners();
  }

  Future<void> deleteNetWorth(int id) async {
    await _databaseService.deleteNetWorth(id);
    notifyListeners();
  }
}
