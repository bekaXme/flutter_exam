class AuthModel {
  final String? fullName;
  final String email;
  final String? mobileNumber;
  final String? dateOfBirth;
  final String password;

  AuthModel({
    this.fullName,
    required this.email,
    this.mobileNumber,
    this.dateOfBirth,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    if (fullName != null) 'fullName': fullName,
    'email': email,
    if (mobileNumber != null) 'mobileNumber': mobileNumber,
    if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
    'password': password,
  };
}