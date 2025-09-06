// import 'package:flutter/material.dart';
// import 'package:flutter_exam/core/services/client.dart';
// import '../../../data/models/your_recipes_model.dart';
//
// class YourRecipesVM extends ChangeNotifier {
//   bool isMyRecipesLoading = true;
//   String? myRecipesError;
//   List<YourRecipesModel> yourRecipesList = [];
//
//   Future<void> fetchMyRecipes() async {
//     print('Starting fetchMyRecipes...');
//     try {
//       isMyRecipesLoading = true;
//       notifyListeners();
//
//       final result = await ApiClient().get<dynamic>('recipes/list');
//       print('API Success: ${result.isSuccess}');
//       print('API Error: ${result.error}');
//       print('API Response Type: ${result.value.runtimeType}');
//       print('API Response: ${result.value}');
//
//       if (result.isSuccess && result.value != null) {
//         final responseData = result.value;
//
//         if (responseData is List) {
//           yourRecipesList = responseData
//               .map((e) => YourRecipesModel.fromJson(e as Map<String, dynamic>))
//               .toList();
//         } else if (responseData is Map<String, dynamic>) {
//           // maybe API wraps the data
//           if (responseData['data'] is List) {
//             yourRecipesList = (responseData['data'] as List)
//                 .map((e) => YourRecipesModel.fromJson(e as Map<String, dynamic>))
//                 .toList();
//           } else {
//             yourRecipesList = [YourRecipesModel.fromJson(responseData)];
//           }
//         } else {
//           throw Exception('Unexpected response format: $responseData');
//         }
//
//         isMyRecipesLoading = false;
//         myRecipesError = null;
//         notifyListeners();
//       } else {
//         throw Exception('API call failed: ${result.error ?? 'No data'}');
//       }
//     } catch (e) {
//       print('Error in fetchMyRecipes: $e');
//       myRecipesError = e.toString();
//       isMyRecipesLoading = false;
//       notifyListeners();
//     }
//   }
// }
