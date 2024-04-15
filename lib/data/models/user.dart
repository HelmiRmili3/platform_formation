import '../../utils/enums.dart';

class UserModel {
  String id;
  String name;
  String email;
  Role role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: Role.values[json['role']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.index,
    };
  }

  factory UserModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return UserModel(
      id: snapshot['id'],
      name: snapshot['name'],
      email: snapshot['email'],
      role: Role.values[snapshot['role']],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    Role? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}
