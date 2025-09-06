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
      final Result<dynamic> result = await ApiClient().get('top-chefs/list');
      dev.log('API Result: $result');

      if (result.isSuccess) {
        final data = result.value;
        if (data is List) {
          chefAccountList = data
              .map((json) => ChefAccountModel.fromJson(json))
              .toList()
              .cast<ChefAccountModel>();
          dev.log('Parsed chefs: $chefAccountList');
          _error = null;
        } else {
          _error = 'Invalid data format';
          chefAccountList = [];
        }
      } else {
        _error = result.error?.toString() ?? 'Unknown error';
        chefAccountList = [];
      }
    } catch (e) {
      _error = 'Error: $e';
      chefAccountList = [];
      dev.log('Error fetching data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String? get error => _error;
}
