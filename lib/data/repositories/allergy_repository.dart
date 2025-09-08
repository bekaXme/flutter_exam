import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/allergy/allergy_page_model.dart';

class AllergyRepository {
  final ApiClient _client;

  AllergyRepository({required ApiClient client}) : _client = client;

  Future<Result<List<AllergyModel>>> fetchAllergies() async {
    final result = await _client.get<List<dynamic>>('allergic/list');

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (data) {
        final list = (data ?? [])
            .map((e) => AllergyModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(list);
      },
    );
  }
}
