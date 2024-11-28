import 'package:equatable/equatable.dart';

class JwtDto extends Equatable {
  final String access_token;
  final String refresh_token;

  const JwtDto({required this.access_token, required this.refresh_token});

  Map<String, dynamic> toMap() {
    return {
      'access_token': access_token,
      'refresh_token': refresh_token,
    };
  }

  factory JwtDto.fromMap(Map<String, dynamic> map) {
    return JwtDto(
        access_token: map['access_token'] as String,
        refresh_token: map['refresh_token'] as String);
  }

  @override
  List<Object> get props => [access_token, refresh_token];
}
