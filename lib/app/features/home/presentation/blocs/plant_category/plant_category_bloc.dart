import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plant_app/app/features/home/data/model/categories_model/categories_model.dart';
import 'package:plant_app/app/features/home/domain/repository/plant_category.repository.dart';

part 'plant_category_event.dart';
part 'plant_category_state.dart';

class PlantCategoryBloc extends Bloc<PlantCategoryEvent, PlantCategoryState> {
  PlantCategoryBloc(this._plantCategoryRepository)
    : super(PlantCategoryInitial()) {
    on<PlantCategoryRequested>(_onPlantCategoryRequested);
  }

  final PlantCategoryRepository _plantCategoryRepository;

  Future<void> _onPlantCategoryRequested(
    PlantCategoryRequested event,
    Emitter<PlantCategoryState> emit,
  ) async {
    emit(PlantCategoryLoading());
    try {
      final response = await _plantCategoryRepository.fetchPlantCategories();

      emit(PlantCategorySuccess(response));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        PlantCategoryFailure(
          error is Exception ? error.toString() : 'Failed to load categories',
        ),
      );
    }
  }
}
