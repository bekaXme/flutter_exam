import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../core/services/client.dart';
import '../../../data/models/my_profile_model.dart';

class MyProfileVM extends ChangeNotifier {
  MyProfileVM() {
    fetchMyProfile();
  }

  String? error;
  bool isLoading = true;
  MyProfileModel? myProfile;

  Future<void> fetchMyProfile() async {
    final box = Hive.box('my_profile');
    try {
      isLoading = true;
      notifyListeners();

      // Check if profile exists in Hive
      if (box.containsKey('profile')) {
        myProfile = box.get('profile') as MyProfileModel?;
        if (myProfile != null) {
          error = null;
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      // Fetch from API if not in Hive
      var response = await ApiClient().get('auth/details/1');
      if (response.statusCode != 200) {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }

      error = null;
      final data = response.data;
      myProfile = MyProfileModel.fromJson(data);

      // Save to Hive
      await box.put('profile', myProfile);
    } catch (e) {
      error = e.toString();
      // Fallback to Hive data if available
      if (box.containsKey('profile')) {
        myProfile = box.get('profile') as MyProfileModel?;
      } else {
        myProfile = null; // Ensure null if no fallback
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}