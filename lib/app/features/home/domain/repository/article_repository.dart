import 'package:plant_app/app/features/home/data/model/article_model/article_model.dart';

abstract class ArticleRepository {
  Future<List<ArticleModel>> fetchArticles();
}
