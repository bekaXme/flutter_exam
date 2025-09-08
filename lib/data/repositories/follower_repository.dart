import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/following/followe_model.dart';

class FollowerRepository {
  final ApiClient _client;

  FollowerRepository({required ApiClient client}) : _client = client;

  Future<Result<List<Follower>>> fetchFollowers() async {
    final result = await _client.get<List<dynamic>>('auth/followers');

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (data) {
        final list = (data ?? [])
            .map((json) => Follower.fromJson(json as Map<String, dynamic>))
            .toList();
        return Result.success(list);
      },
    );
  }

  Future<Result<void>> follow(int id) async {
    final result =
    await _client.post('auth/follow/$id', data: {'id': id});
    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (_) => Result.success(null),
    );
  }

  Future<Result<void>> unfollow(int id) async {
    final result =
    await _client.post('auth/unfollow/$id', data: {'id': id});
    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (_) => Result.success(null),
    );
  }

  Future<Result<void>> removeFollower(int id) async {
    final result =
    await _client.post('auth/remove-follower/$id', data: {'id': id});
    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (_) => Result.success(null),
    );
  }
}
