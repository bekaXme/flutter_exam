import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import '../../../core/result/result.dart';
import '../../../core/services/client.dart';
import '../../../data/models/chef_account_model.dart';

class ChefAccountVM extends ChangeNotifier {
  ChefAccountVM() {
    fetchChefAccount();
  }

  bool isLoading = true;
  String? _error;
  List<ChefAccountModel> chefAccountList = [];

  Future<void> fetchChefAccount() async {
    try {
      dev.log('Fetching chef account data...');
      Result<List<dynamic>> result = await ApiClient().get<List<dynamic>>('top-chefs/list');
      dev.log('API Result: $result');

      if (result.isSuccess) {
        if (result.value is List) {
          chefAccountList = (result.value as List)
              .map((json) => ChefAccountModel.fromJson(json))
              .toList();
          dev.log('Parsed chefs: $chefAccountList');
        } else {
          _error = 'Invalid data format';
        }
      } else {
        _error = result.error?.toString() ?? 'Unknown error';
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      _error = 'Error: $e';
      dev.log('Error fetching data: $e');
      notifyListeners();
    }
  }
}