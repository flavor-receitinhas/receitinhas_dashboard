import 'package:flutter/material.dart';

class RoleEntity {
  final String id;
  final String userId;
  final Roles role;

  RoleEntity({required this.id, required this.userId, required this.role});

  factory RoleEntity.fromMap(Map<String, dynamic> map) {
    return RoleEntity(
      id: map['id'] as String,
      userId: map['userId'] as String,
      role: Roles.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => throw ArgumentError('Invalid role: ${map['type']}'),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'type': role.name};
  }
}

enum Roles {
  common(Colors.blue),
  admin(Colors.amber);

  final Color color;
  const Roles(this.color);

  static Roles fromString(String name) {
    return Roles.values.firstWhere(
      (e) => e.name == name,
      orElse: () => throw ArgumentError('Invalid role: $name'),
    );
  }
}
