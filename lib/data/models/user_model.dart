class UserModel {
  final String id;
  final String name;
  final String role;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
