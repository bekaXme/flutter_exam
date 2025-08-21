class ChefAccountModel {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String profilePhoto;

  ChefAccountModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
  });

  factory ChefAccountModel.fromJson(Map<String, dynamic> json) {
    return ChefAccountModel(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePhoto: json['profilePhoto'],
    );
  }
}
