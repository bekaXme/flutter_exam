import 'package:flutter/material.dart';
import '../../../core/services/client.dart';
import '../../../data/models/chef_account_model.dart';

class ChefAccountVM extends ChangeNotifier {
  final int? id;
  String? error;
  bool isLoading = false;
  List<ChefAccountModel> chefAccountList = [];

  ChefAccountVM({this.id}) {
    if (id != null) {
      fetchChefAccount();
    }
  }

  Future<void> fetchChefAccount() async {
    if (id == null) {
      error = 'No ID provided';
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      error = null;
      notifyListeners();

      print('Fetching chef account for id: $id'); // Debug log
      final result = await ApiClient().get<List<dynamic>>('chef-account/id/$id');

      if (result.isSuccess) {
        final data = result.data ?? [];
        print('API Response: $data'); // Debug log for response

        chefAccountList = data
            .map((e) => ChefAccountModel.fromJson(e as Map<String, dynamic>))
            .toList();

        print('Chef Account List: $chefAccountList'); // Debug log for parsed data
      } else {
        error = result.error?.toString() ?? 'Failed to load chef account';
        print('API Error: $error'); // Debug log for error
      }
    } catch (e) {
      error = 'Failed to load chef account: $e';
      print('Exception: $error'); // Debug log for exceptions
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
