import 'package:flutter/material.dart';
import '../../../core/result/result.dart';
import '../../../core/services/client.dart';
import '../../../data/models/following/followe_model.dart';
import '../../../data/repositories/follower_repository.dart';

class FollowerViewModel extends ChangeNotifier {
  final FollowerRepository _repository;

  FollowerViewModel({FollowerRepository? repository})
      : _repository = repository ?? FollowerRepository(client: ApiClient()) {
    fetchFollowers();
  }

  List<Follower> followers = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchFollowers() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _repository.fetchFollowers();

    result.fold(
      onError: (err) {
        error = err.toString();
        followers = [];
      },
      onSuccess: (data) {
        followers = data;
        error = null;
      },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> follow(int id) async {
    final result = await _repository.follow(id);
    _handleActionResult(result);
  }

  Future<void> unfollow(int id) async {
    final result = await _repository.unfollow(id);
    _handleActionResult(result);
  }

  Future<void> removeFollower(int id) async {
    final result = await _repository.removeFollower(id);
    _handleActionResult(result);
  }

  void _handleActionResult(Result<void> result) {
    result.fold(
      onError: (err) => error = err.toString(),
      onSuccess: (_) => fetchFollowers(), // Refresh list on success
    );
  }
}
