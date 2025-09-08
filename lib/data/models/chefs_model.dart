class ChefsModel {
  final int id;
  final String chefPhoto;
  final String chefName;
  final String chefSurname;
  final String chefUsername;

  ChefsModel({
    required this.id,
    required this.chefPhoto,
    required this.chefName,
    required this.chefSurname,
    required this.chefUsername,
  });

  factory ChefsModel.fromJson(Map<String, dynamic> json) {
    return ChefsModel(
      id: json['id'] as int? ?? 0,
      chefPhoto: json['chefPhoto'] as String? ?? '',
      chefName: json['chefName'] as String? ?? '',
      chefSurname: json['chefSurname'] as String? ?? '',
      chefUsername: json['chefUsername'] as String? ?? '',
    );
  }
}