import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plant_app/app/core/config/app_config.dart';
import 'package:plant_app/app/core/network/network_client.dart';
import 'package:plant_app/app/features/home/data/model/article_model/article_model.dart';
import 'package:plant_app/app/features/home/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  const ArticleRepositoryImpl(this._networkClient);

  final NetworkClient _networkClient;

  @override
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final response = await _networkClient.get(AppConfig.articleEndPoint);

      dynamic data = response.data;

      if (data is String) {
        data = jsonDecode(data);
      }

      if (data is List) {
        final articles = data
            .map((item) => ArticleModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return articles;
      } else {
        throw const FormatException(
          'Unexpected response format from the server.',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch articles: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }
}
