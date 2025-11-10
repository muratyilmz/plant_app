import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plant_app/app/features/home/data/model/article_model/article_model.dart';
import 'package:plant_app/app/features/home/domain/repository/article_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc(this._articleRepository) : super(const ArticleInitial()) {
    on<ArticleRequested>(_onArticleRequested);
  }

  final ArticleRepository _articleRepository;

  Future<void> _onArticleRequested(
    ArticleRequested event,
    Emitter<ArticleState> emit,
  ) async {
    emit(const ArticleLoading());
    try {
      final articles = await _articleRepository.fetchArticles();
      emit(ArticleSuccess(articles));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        ArticleFailure(
          error is Exception ? error.toString() : 'Failed to load articles',
        ),
      );
    }
  }
}
