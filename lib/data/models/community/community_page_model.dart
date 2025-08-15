import 'package:flutter/material.dart';
import '../../../core/services/client.dart';

class CommunityModel extends ChangeNotifier {
  CommunityModel() {}

  String? error;
  bool isLoading = true;
  List accounts = [];

  Future<void> getAccounts() async {
    isLoading = true;
    notifyListeners();
    var response = await ApiClient().get("allergic/list");
  }
}
