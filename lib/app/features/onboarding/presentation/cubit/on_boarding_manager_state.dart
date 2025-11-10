part of 'on_boarding_manager_cubit.dart';

class OnBoardingManagerState extends Equatable {
  const OnBoardingManagerState({
    required this.currentPage,
    required this.pageCount,
    this.isCompleted = false,
  });

  final int currentPage;
  final int pageCount;
  final bool isCompleted;

  OnBoardingManagerState copyWith({
    int? currentPage,
    int? pageCount,
    bool? isCompleted,
  }) {
    return OnBoardingManagerState(
      currentPage: currentPage ?? this.currentPage,
      pageCount: pageCount ?? this.pageCount,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object> get props => [currentPage, pageCount, isCompleted];
}
