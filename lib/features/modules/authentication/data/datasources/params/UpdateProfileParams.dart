import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/core/utils/error/JsonSerilizable.dart';

class Updateprofileparams extends Equatable
    implements JsonSerializable<Updateprofileparams> {
  final String? email;
  final String? name;
  final String? avatar;

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  List<Object?> get props => [email, name];

  const Updateprofileparams({
    this.email,
    this.name,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      if (email != null) 'email': this.email,
      if (name != null) 'name': this.name,
      if (avatar != null) 'avatar': this.avatar,
    };
  }

  factory Updateprofileparams.fromMap(Map<String, dynamic> map) {
    return Updateprofileparams(
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  Updateprofileparams copyWith({
    String? email,
    String? name,
    String? avatar,
  }) {
    return Updateprofileparams(
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
