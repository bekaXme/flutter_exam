import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/top_chefs_model.dart';

class TopChefsRepository {
  final ApiClient _client;

  TopChefsRepository({required ApiClient client}) : _client = client;

  Future<Result<List<TopChefsModel>>> fetchTopChefs() async {
    final result = await _client.get<List<dynamic>>('top-chefs/list');

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (success) {
        final data = success ?? [];
        final chefs = data
            .map((e) => TopChefsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(chefs);
      },
    );
  }
}
