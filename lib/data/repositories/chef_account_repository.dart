import '../../core/result/result.dart';
import '../../core/services/client.dart';
import '../models/chef_account_model.dart';

class ChefAccountRepository {
  final ApiClient _client;

  ChefAccountRepository({required ApiClient client}) : _client = client;

  Future<Result<List<ChefAccountModel>>> fetchChefAccount(int id) async {
    final result = await _client.get<List<dynamic>>('chef-account/id/$id');

    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (success) {
        final data = success ?? [];
        final chefAccounts = data
            .map((e) => ChefAccountModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.success(chefAccounts);
      },
    );
  }
}
