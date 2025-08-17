class ChefsModel {
  final String chefName;
  final String chefPhoto;
  final String chefSurname;
  final String chefUsername;

  ChefsModel({
    required this.chefName,
    required this.chefPhoto,
    required this.chefSurname,
    required this.chefUsername,
  });

  factory ChefsModel.fromJson(Map<String, dynamic> json) {
    return ChefsModel(
      chefName: json['firstName'] as String,
      chefPhoto: json['profilePhoto'] as String,
      chefSurname: json['lastName'] as String,
      chefUsername: json['username'] as String,
    );
  }
}
