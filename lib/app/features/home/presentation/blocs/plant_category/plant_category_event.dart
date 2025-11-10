part of 'plant_category_bloc.dart';

sealed class PlantCategoryEvent extends Equatable {
  const PlantCategoryEvent();

  @override
  List<Object> get props => [];
}

class PlantCategoryRequested extends PlantCategoryEvent {
  const PlantCategoryRequested();
}
