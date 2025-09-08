import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/chefs_model.dart';

class ChefsRepository {
  final ApiClient _client;

  ChefsRepository({required ApiClient client}) : _client = client;

  Future<Result<List<ChefsModel>>> fetchChefs() async {
    final result = await _client.get<List<dynamic>>('top-chefs/list');

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (success) {
        final data = success ?? [];
        final chefs = data
            .map((e) => ChefsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(chefs);
      },
    );
  }
}
