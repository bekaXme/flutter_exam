import 'package:flutter/cupertino.dart';
import 'package:flutter_exam/data/models/my_recipes_model.dart';
import 'package:flutter_exam/data/models/recently_recipes_model.dart';
import 'package:flutter_exam/data/models/top_chefs_model.dart';
import '../../../core/services/client.dart';

class TopChefsVM extends ChangeNotifier{
  TopChefsVM() {
    fetchChefs();
  }
  String? error;
  bool isLoading = true;
  List<TopChefsModel> TopChefsList = [];

  Future<void> fetchChefs() async {
    isLoading = true;
    notifyListeners();
    var response = await request.get('top-chefs/list');
    if (response.statusCode != 200) {
      throw Exception('Failed to load trend recipes');
    }else {
      error = null;
      List data = response.data;
      TopChefsList = data.map((e) => TopChefsModel.fromJson(e)).toList();
    }
    isLoading = false;
    notifyListeners();
  }
}