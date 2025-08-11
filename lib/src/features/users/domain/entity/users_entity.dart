class UsersEntity {
  final String id;
  final String email;
  final bool emailVerified;
  final String signProvider;
  final String createdAt;
  bool disabled;

  UsersEntity({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.signProvider,
    required this.createdAt,
    required this.disabled,
  });

  factory UsersEntity.fromMap(Map<String, dynamic> map) {
    return UsersEntity(
      id: map['id'] as String,
      email: map['email'] as String,
      emailVerified: map['emailVerified'] as bool,
      signProvider: map['signProvider'] as String,
      createdAt: map['createdAt'] as String,
      disabled: map['disabled'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'emailVerified': emailVerified,
      'signProvider': signProvider,
      'createdAt': createdAt,
      'disabled': disabled,
    };
  }
}
