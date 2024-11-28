import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/core/utils/error/JsonSerilizable.dart';

class LoginParams extends Equatable implements JsonSerializable<LoginParams> {
  final String? email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

  @override
  Map<String, dynamic> toJson() {
    return {if (email != null) "email": email, "password": password};
  }
}

class RegisterUserParams extends Equatable
    implements JsonSerializable<LoginParams> {
  final String email;
  final String password;
  final String? picture;
  final String name;

//<editor-fold desc="Data Methods">
  const RegisterUserParams({
    required this.email,
    required this.password,
    required this.name,
    this.picture,
  });

  @override
  List<Object?> get props => [email, password, name, picture];

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  RegisterUserParams copyWith({
    String? email,
    String? password,
    String? picture,
    String? name,
  }) {
    return RegisterUserParams(
      email: email ?? this.email,
      password: password ?? this.password,
      picture: picture ?? this.picture,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
      'avatar': this.picture,
      'name': this.name,
    };
  }

  factory RegisterUserParams.fromMap(Map<String, dynamic> map) {
    return RegisterUserParams(
      email: map['email'] as String,
      password: map['password'] as String,
      picture: map['picture'] as String,
      name: map['name'] as String,
    );
  }
}
