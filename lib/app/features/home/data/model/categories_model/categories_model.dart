import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';
import 'meta.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class CategoriesModel extends Equatable {
  final List<Datum>? data;
  final Meta? meta;

  const CategoriesModel({this.data, this.meta});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return _$CategoriesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [data, meta];
}
