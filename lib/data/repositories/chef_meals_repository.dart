import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/chef_meal_model.dart';

class ChefMealsRepository {
  final ApiClient _client;

  ChefMealsRepository({required ApiClient client}) : _client = client;

  Future<Result<List<ChefMealModel>>> fetchChefMeals() async {
    final result = await _client.get<List<dynamic>>('recipes/list');

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (success) {
        final data = success ?? [];
        final meals = data
            .map((e) => ChefMealModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(meals);
      },
    );
  }
}
