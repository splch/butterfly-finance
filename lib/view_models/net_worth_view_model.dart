import 'package:flutter/foundation.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/net_worth.dart';

class NetWorthViewModel with ChangeNotifier {
  final DatabaseService databaseService;
  List<NetWorth?> _netWorthRecords = [];

  List<NetWorth?> get netWorthRecords => _netWorthRecords;

  NetWorthViewModel({required this.databaseService});

  Future<void> loadNetWorthRecords() async {
    try {
      _netWorthRecords = await databaseService.getAllNetWorthRecords();
      notifyListeners(); // Notify listening widgets to rebuild with the new data
    } catch (e) {
      // Error handling: Log, set error state, show messages to users, etc.
      print('Error loading net worth records: $e');
    }
  }

  // Implement additional functionality as needed, such as adding, updating, or deleting net worth records
}
