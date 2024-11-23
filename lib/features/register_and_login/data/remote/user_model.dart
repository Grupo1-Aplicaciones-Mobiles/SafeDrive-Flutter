class UserModel {
  final String id;
  final String username;
  final String email;
  final String mobileNumber;
  final String password;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobile_number']
          .toString(), // Convertimos a String en caso de que sea int
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'mobile_number': mobileNumber,
      'password': password,
    };
  }
}
