import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'image.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum extends Equatable {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? title;
  final int? rank;
  final Image? image;

  const Datum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.title,
    this.rank,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, name, createdAt, updatedAt, publishedAt, title, rank, image];
  }
}
