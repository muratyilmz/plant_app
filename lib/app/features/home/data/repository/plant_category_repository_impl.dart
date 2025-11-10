import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:plant_app/app/core/config/app_config.dart';
import 'package:plant_app/app/core/network/network_client.dart';
import 'package:plant_app/app/features/home/data/model/categories_model/categories_model.dart';
import 'package:plant_app/app/features/home/domain/repository/plant_category.repository.dart';

class PlantCategoryRepositoryImpl implements PlantCategoryRepository {
  const PlantCategoryRepositoryImpl(this._networkClient);

  final NetworkClient _networkClient;

  @override
  Future<CategoriesModel> fetchPlantCategories() async {
    try {
      final response = await _networkClient.get<dynamic>(
        AppConfig.plantCategoryEndPoint,
      );

      dynamic responseData = response.data;

      if (responseData is String) {
        try {
          responseData = json.decode(responseData);
          developer.log(
            'Response was a String, decoded to: ${responseData.runtimeType}',
            name: 'PlantCategoryRepositoryImpl',
          );
        } catch (e) {
          developer.log(
            'Failed to decode JSON string: $e',
            name: 'PlantCategoryRepositoryImpl',
          );
          throw Exception('Invalid JSON response');
        }
      }

      Map<String, dynamic> jsonData;
      if (responseData is Map<String, dynamic>) {
        jsonData = responseData;
      } else if (responseData is Map) {
        jsonData = Map<String, dynamic>.from(responseData);
      } else {
        developer.log(
          'Unexpected response type: ${responseData.runtimeType}',
          name: 'PlantCategoryRepositoryImpl',
        );
        throw Exception('Expected Map but got ${responseData.runtimeType}');
      }

      if (jsonData['data'] == null) {
        throw Exception('Invalid response format: missing "data" field');
      }

      return CategoriesModel.fromJson(jsonData);
    } on DioException catch (error, stackTrace) {
      developer.log(
        'fetchPlantCategories DioException',
        name: 'PlantCategoryRepositoryImpl',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (error, stackTrace) {
      developer.log(
        'fetchPlantCategories failed',
        name: 'PlantCategoryRepositoryImpl',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
