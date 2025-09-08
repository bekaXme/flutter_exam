class AuthModel {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String birthDate;
  final String password;
  final int cookingLevelId;
  final List<int> allergicIngredients;
  final List<int> cuisines;

  AuthModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.password,
    this.cookingLevelId = 0,
    this.allergicIngredients = const [],
    this.cuisines = const [],
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phoneNumber': phoneNumber,
    'birthDate': birthDate,
    'password': password,
    'cookingLevelId': cookingLevelId,
    'allergicIngredients': allergicIngredients,
    'cuisines': cuisines,
  };
}