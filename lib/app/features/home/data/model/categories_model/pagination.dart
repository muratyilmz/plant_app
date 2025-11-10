import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination extends Equatable {
  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  const Pagination({this.page, this.pageSize, this.pageCount, this.total});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return _$PaginationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [page, pageSize, pageCount, total];
}
