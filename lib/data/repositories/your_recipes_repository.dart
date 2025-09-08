import 'package:flutter_exam/core/result/result.dart';
import 'package:flutter_exam/core/services/client.dart';
import '../../data/models/your_recipes_model.dart';

class YourRecipesRepository {
  final ApiClient _apiClient;

  YourRecipesRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<Result<List<YourRecipesModel>>> getMyRecipes() async {
    try {
      final result = await _apiClient.get<dynamic>('recipes/list');
      print('Repository: API result - isSuccess: ${result.isSuccess}, error: ${result.error}, value: ${result.value}');
      if (result.isSuccess && result.value != null) {
        final responseData = result.value;
        List<YourRecipesModel> recipes;

        if (responseData is List) {
          recipes = responseData
              .map((e) => YourRecipesModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (responseData is Map<String, dynamic> && responseData['data'] is List) {
          recipes = (responseData['data'] as List)
              .map((e) => YourRecipesModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return Result.error(Exception('Unexpected response format: $responseData'));
        }

        return Result.success(recipes);
      } else {
        return Result.error(Exception('API call failed: ${result.error ?? 'No data'}'));
      }
    } catch (e) {
      print('Repository: Error fetching recipes: $e');
      return Result.error(Exception('Failed to fetch recipes: $e'));
    }
  }
}