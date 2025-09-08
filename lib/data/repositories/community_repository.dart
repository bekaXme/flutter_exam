import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/community_model.dart';

class CommunityRepository {
  final ApiClient _client;

  CommunityRepository({required ApiClient client}) : _client = client;

  Future<Result<List<CommunityMainModel>>> fetchCommunityData() async {
    final result = await _client.get<List<dynamic>>('recipes/community/list');

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (success) {
        final data = success ?? [];
        final communities = data
            .map((e) => CommunityMainModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(communities);
      },
    );
  }
}
