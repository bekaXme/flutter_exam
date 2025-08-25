import 'package:flutter/material.dart';

import '../../../core/services/client.dart';
import '../../../data/models/community/community_page_model.dart';
import '../../../data/models/community_model.dart';

class CommunityMainVM extends ChangeNotifier {
  CommunityMainVM() {
    fetchCommunityData();
  }

  bool isCommunityLoading = true;
  String? communityError;
  List<CommunityMainModel> communityList = [];

  Future<void> fetchCommunityData() async {
    try {
      isCommunityLoading = true;
      communityError = null;
      notifyListeners();

      var response = await ApiClient().get('recipes/community/list');
      if (response.isSuccess) {
        communityList = (response.data as List)
            .map((item) => CommunityMainModel.fromJson(item))
            .toList();
      } else {
        communityError = response.error?.toString() ?? 'Unknown error';
      }
    } catch (e) {
      communityError = e.toString();
    } finally {
      isCommunityLoading = false;
      notifyListeners();
    }
  }
}
