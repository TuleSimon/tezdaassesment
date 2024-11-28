import 'package:equatable/equatable.dart';

abstract class JsonSerializable<T> {
  Map<String, dynamic> toJson();

  // Factory method that returns an instance of the subclass
  factory JsonSerializable.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class Nothing extends Equatable implements JsonSerializable<Nothing> {
  const Nothing();
  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toJson() => {};

  @override
  factory Nothing.fromJson() => const Nothing();
}
