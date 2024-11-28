import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/core/utils/error/JsonSerilizable.dart';

class Updateprofileparams extends Equatable
    implements JsonSerializable<Updateprofileparams> {
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? phone;

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  List<Object?> get props => [first_name, last_name, email, phone];

  const Updateprofileparams({
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      if (first_name != null) 'first_name': this.first_name,
      if (last_name != null) 'last_name': this.last_name,
      if (email != null) 'email': this.email,
      if (phone != null) 'phone': this.phone,
    };
  }

  factory Updateprofileparams.fromMap(Map<String, dynamic> map) {
    return Updateprofileparams(
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
    );
  }
}
