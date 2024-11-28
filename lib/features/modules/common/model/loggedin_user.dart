import 'package:equatable/equatable.dart';

class LoggedInUser extends Equatable {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String? token;
  final String? refreshToken;
  final String avatar;

  const LoggedInUser({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    this.token,
    this.refreshToken,
    required this.avatar,
  });

  // `copyWith` method to allow creating a new object with updated fields
  LoggedInUser copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    String? role,
    String? token,
    String? refreshToken,
    String? avatar,
  }) {
    return LoggedInUser(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      role: role ?? this.role,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      avatar: avatar ?? this.avatar,
    );
  }

  // Required for `Equatable`
  @override
  List<Object?> get props =>
      [id, email, password, name, role, avatar, token, refreshToken];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'token': this.token,
      'refreshToken': this.refreshToken,
      'password': this.password,
      'name': this.name,
      'role': this.role,
      'avatar': this.avatar,
    };
  }

  factory LoggedInUser.fromMap2(Map<String, dynamic> map) {
    return LoggedInUser(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      role: map['role'] as String,
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
      avatar: map['avatar'] as String,
    );
  }

  factory LoggedInUser.fromMap(Map<String, dynamic> map) {
    return LoggedInUser(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      role: map['role'] as String,
      avatar: map['avatar'] as String,
    );
  }
}
