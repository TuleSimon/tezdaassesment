import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/core/utils/error/JsonSerilizable.dart';

class NoParams extends Equatable implements JsonSerializable<NoParams> {
  const NoParams();

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
