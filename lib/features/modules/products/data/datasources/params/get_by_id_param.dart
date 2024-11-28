import 'package:equatable/equatable.dart';

class GetByIdParam extends Equatable {
  final String id;

//<editor-fold desc="Data Methods">
  const GetByIdParam({
    required this.id,
  });

  @override
  String toString() {
    return 'GetOrderByIdParams{' + ' orderId: $id,' + '}';
  }

  GetByIdParam copyWith({
    String? id,
  }) {
    return GetByIdParam(
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [id];

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
    };
  }
}
