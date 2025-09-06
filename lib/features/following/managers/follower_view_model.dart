import 'package:flutter_exam/core/result/result.dart';
import '../../../core/services/client.dart';
import '../../../data/models/following/followe_model.dart';

class FollowerViewModel {
  final ApiClient _apiClient = ApiClient();
  List<Follower> followers = [];

  Future<void> fetchFollowers() async {
    final result = await _apiClient.get('auth/followers');
    result.fold(
      onError: (error) => print('Error fetching followers: $error'),
      onSuccess: (data) => followers = (data as List).map((json) => Follower.fromJson(json)).toList(),
    );
  }

  Future<void> follow(int id) async {
    final result = await _apiClient.post('auth/follow/$id', data: {'id': id});
    _handleResult(result);
  }

  Future<void> unfollow(int id) async {
    final result = await _apiClient.post('auth/unfollow/$id', data: {'id': id});
    _handleResult(result);
  }

  Future<void> removeFollower(int id) async {
    final result = await _apiClient.post('auth/remove-follower/$id', data: {'id': id});
    _handleResult(result);
  }

  void _handleResult(Result<dynamic> result) {
    result.fold(
      onError: (error) => print('Operation failed: $error'),
      onSuccess: (_) => fetchFollowers(), // Refresh list on success
    );
  }
}