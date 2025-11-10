part of 'plant_category_bloc.dart';

sealed class PlantCategoryState extends Equatable {
  const PlantCategoryState();

  @override
  List<Object> get props => [];
}

class PlantCategoryInitial extends PlantCategoryState {}

class PlantCategoryLoading extends PlantCategoryState {}

class PlantCategorySuccess extends PlantCategoryState {
  const PlantCategorySuccess(this.categories);

  final CategoriesModel categories;

  @override
  List<Object> get props => [categories];
}

class PlantCategoryFailure extends PlantCategoryState {
  const PlantCategoryFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
