class UserEntity {
  final String id;
  final String email;
  UserEntity({required this.id, required this.email});

  Map<String, dynamic> toJson() => {'id': id, 'email': email};
  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      UserEntity(id: json['id'], email: json['email']);
}
