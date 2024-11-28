import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/core/utils/error/JsonSerilizable.dart';

class UpdateprofilePicparams extends Equatable
    implements JsonSerializable<UpdateprofilePicparams> {
  final String path;

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  List<Object?> get props => [path];

  const UpdateprofilePicparams({
    required this.path,
  });

  Map<String, dynamic> toMap() {
    return {
      'path': this.path,
    };
  }

  factory UpdateprofilePicparams.fromMap(Map<String, dynamic> map) {
    return UpdateprofilePicparams(
      path: map['path'] as String,
    );
  }
}
