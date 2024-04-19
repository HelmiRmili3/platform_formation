import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/enums.dart';

class UserModel {
  String id;
  String name;
  String email;
  Role role;
  String image;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: Role.values[json['role']],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.index,
      'image': image
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    Role? role,
    String? image,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      image: image ?? this.image,
    );
  }
}
