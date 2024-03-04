import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String? id;
  String? code;
  String? description;
  String? commonName;
  double ? averagePrice;
  double ? salePrice;
  int? unit;
  int? categoryId;
  Category? category;
  String? userId;

  Product({
    this.id,
    this.code,
    this.description,
    this.commonName,
    this.averagePrice,
    this.salePrice,
    this.unit,
    this.categoryId,
    this.category,
    this.userId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? id,
    String? code,
    String? description,
    String? commonName,
    double ? averagePrice,
    double ? salePrice,
    int? unit,
    int? categoryId,
    Category? category,
    String? userId,
  }) {
    return Product(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      commonName: commonName ?? this.commonName,
      averagePrice: averagePrice ?? this.averagePrice,
      salePrice: salePrice ?? this.salePrice,
      unit: unit ?? this.unit,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      userId: userId ?? this.userId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Product) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      code.hashCode ^
      description.hashCode ^
      commonName.hashCode ^
      averagePrice.hashCode ^
      salePrice.hashCode ^
      unit.hashCode ^
      categoryId.hashCode ^
      category.hashCode ^
      userId.hashCode;
}
