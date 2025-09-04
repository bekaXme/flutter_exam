import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/models/post_cuisines_model.dart';

class CuisineVM extends ChangeNotifier {
  String? error;
  bool isLoading = false;

  final TextEditingController imageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  Future<void> createCuisine() async {
    if (imageController.text.trim().isEmpty || titleController.text.trim().isEmpty) {
      error = 'Image and Title are required.';
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final url = Uri.parse("http://192.168.0.103:8888/api/v1/cuisines/create");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(CuisineModel(
          image: imageController.text.trim(),
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          time: timeController.text.trim(),
          ingredients: [],
          instructions: [],
        ).toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success: clear input
        imageController.clear();
        titleController.clear();
      } else {
        final data = jsonDecode(response.body);

        if (data is Map && data['errors'] != null) {
          error = '${data['title'] ?? "Error"}\n'
              '${(data['errors'] as Map).entries.map((e) => '${e.key}: ${(e.value as List).join(", ")}').join("\n")}';
        } else {
          error = 'Failed to create cuisine: ${response.statusCode}';
        }
      }
    } catch (e) {
      error = 'An error occurred: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
