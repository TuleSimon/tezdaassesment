import 'package:equatable/equatable.dart';

class GetProductParam extends Equatable {
  final int offset;
  final int limit;
  final String? title;
  final String? price;
  final String? price_min;
  final String? price_max;
  final String? categoryId;
  final bool hasMore;

//<editor-fold desc="Data Methods">
  const GetProductParam(
      {this.offset = 0,
      this.limit = 10,
      this.title,
      this.price,
      this.price_min,
      this.price_max,
      this.categoryId,
      this.hasMore = true});

  Map<String, String> toMap() {
    return {
      'offset': offset.toString(),
      'limit': limit.toString(),
      if (title != null) 'title': title!,
      if (price != null) 'price': price!,
      if (price_min != null) 'start_date': price_min!,
      if (price_max != null) 'end_date': price_max!,
      if (categoryId != null) 'categoryId': categoryId!,
    };
  }

  @override
  List<Object?> get props => [
        offset,
        limit,
        title,
        price,
        price_min,
        price_max,
        categoryId,
        hasMore,
      ];

  GetProductParam copyWith({
    int? offset,
    int? limit,
    String? title,
    String? price,
    String? price_min,
    String? price_max,
    String? categoryId,
    bool? hasMore,
  }) {
    return GetProductParam(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      title: title,
      price: price,
      price_min: price_min,
      price_max: price_max,
      categoryId: categoryId,
      hasMore: hasMore ?? false,
    );
  }
}
