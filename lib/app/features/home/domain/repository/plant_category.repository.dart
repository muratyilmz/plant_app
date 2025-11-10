import 'package:plant_app/app/features/home/data/model/categories_model/categories_model.dart';

abstract class PlantCategoryRepository {
  Future<CategoriesModel> fetchPlantCategories();
}
