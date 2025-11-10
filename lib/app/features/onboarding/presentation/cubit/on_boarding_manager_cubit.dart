import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:plant_app/app/core/network/onboarding_storage_service.dart';

part 'on_boarding_manager_state.dart';

class OnBoardingManagerCubit extends Cubit<OnBoardingManagerState> {
  final OnboardingStorageService _storageService;

  OnBoardingManagerCubit({
    int pageCount = 3,

    OnboardingStorageService? storageService,
  }) : assert(pageCount > 0, 'pageCount must be positive'),
       _storageService = storageService ?? OnboardingStorageService(),
       super(OnBoardingManagerState(currentPage: 0, pageCount: pageCount));

  bool get isFirstPage => state.currentPage == 0;

  bool get isLastPage => state.currentPage == state.pageCount - 1;

  void setPage(int index) {
    if (index < 0 || index >= state.pageCount) return;
    emit(state.copyWith(currentPage: index));
  }

  void nextPage() {
    if (isLastPage) return;
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  void previousPage() {
    if (isFirstPage) return;
    emit(state.copyWith(currentPage: state.currentPage - 1));
  }

  void reset() {
    emit(state.copyWith(currentPage: 0));
  }

  Future<void> markCompleted() async {
    try {
      await _storageService.markOnboardingCompleted();
      emit(state.copyWith(isCompleted: true));
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isOnboardingCompleted() async {
    try {
      return await _storageService.isOnboardingCompleted();
    } catch (e) {
      return false;
    }
  }
}
