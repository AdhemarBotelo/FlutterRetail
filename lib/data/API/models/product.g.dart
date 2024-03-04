// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      commonName: json['commonName'] as String?,
      averagePrice: (json['averagePrice'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      unit: json['unit'] as int?,
      categoryId: json['categoryId'] as int?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'commonName': instance.commonName,
      'averagePrice': instance.averagePrice,
      'salePrice': instance.salePrice,
      'unit': instance.unit,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'userId': instance.userId,
    };
