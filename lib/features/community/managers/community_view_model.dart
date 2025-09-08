import 'package:flutter/material.dart';
import '../../../core/result/result.dart';
import '../../../core/services/client.dart';
import '../../../data/models/community_model.dart';
import '../../../data/repositories/community_repository.dart';

class CommunityMainVM extends ChangeNotifier {
  final CommunityRepository _repository;

  CommunityMainVM({CommunityRepository? repository})
      : _repository = repository ?? CommunityRepository(client: ApiClient()) {
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

      final Result<List<CommunityMainModel>> result =
      await _repository.fetchCommunityData();

      result.fold(
        onError: (err) {
          communityError = err.toString();
          communityList = [];
        },
        onSuccess: (data) {
          communityList = data;
          communityError = null;
        },
      );
    } catch (e) {
      communityError = e.toString();
      communityList = [];
    } finally {
      isCommunityLoading = false;
      notifyListeners();
    }
  }

  void retryFetch() {
    fetchCommunityData();
  }
}
