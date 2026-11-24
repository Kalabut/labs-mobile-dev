class UserModel {
  const UserModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  final String name;
  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}
