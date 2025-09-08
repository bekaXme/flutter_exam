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

      if (box.containsKey('profile')) {
        myProfile = box.get('profile') as MyProfileModel?;
        if (myProfile != null) {
          error = null;
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      final result = await ApiClient().get('top-chefs/list', queryParameters: {'Page': 1, 'Limit': 1});
      result.fold(
        onError: (exception) {
          error = exception.toString();
          if (box.containsKey('profile')) {
            myProfile = box.get('profile') as MyProfileModel?;
          } else {
            myProfile = null;
          }
        },
        onSuccess: (data) {
          error = null;
          if (data is Map && data.containsKey('data') && data['data'] is List) {
            final profileData = data['data'].firstWhere((item) => item is Map, orElse: () => {});
            myProfile = MyProfileModel.fromJson(profileData);
          } else if (data is List) {
            final profileData = data.isNotEmpty ? data.first : {};
            myProfile = MyProfileModel.fromJson(profileData);
          } else {
            myProfile = MyProfileModel.fromJson(data);
          }
          box.put('profile', myProfile);
        },
      );
    } catch (e) {
      error = e.toString();
      if (box.containsKey('profile')) {
        myProfile = box.get('profile') as MyProfileModel?;
      } else {
        myProfile = null;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}