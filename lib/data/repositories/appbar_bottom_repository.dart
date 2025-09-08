import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/appbar_bottom_model.dart';

class AppbarBottomRepository {
  final ApiClient _client;

  AppbarBottomRepository({required ApiClient client}) : _client = client;

  Future<Result<List<AppBarBottomModel>>> fetchCategories() async {
    final result = await _client.get<List<dynamic>>('categories/list');

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (success) {
        final data = success ?? [];
        final categories = data
            .map((e) => AppBarBottomModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(categories);
      },
    );
  }
}
