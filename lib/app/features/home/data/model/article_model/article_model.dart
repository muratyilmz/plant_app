import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends Equatable {
  final int? id;
  final String? title;
  final String? subtitle;
  @JsonKey(name: 'image_uri')
  final String? imageUri;
  final String? uri;
  final int? order;

  const ArticleModel({
    this.id,
    this.title,
    this.subtitle,
    this.imageUri,
    this.uri,
    this.order,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return _$ArticleModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, title, subtitle, imageUri, uri, order];
}
