import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/recently_recipes_model.dart';

class RecentRecipesRepository {
  final ApiClient _client;

  RecentRecipesRepository({required ApiClient client}) : _client = client;

  Future<Result<List<RecentlyRecipesModel>>> fetchRecentRecipes({int limit = 2}) async {
    final result = await _client.get<dynamic>(
      'recipes/list',
      queryParameters: {'Limit': limit},
    );

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (data) {
        final listData = data is List ? data : (data['data'] as List? ?? []);
        final recipes = listData
            .map((e) => RecentlyRecipesModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(recipes);
      },
    );
  }
}
