part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {
  const ArticleInitial();
}

class ArticleLoading extends ArticleState {
  const ArticleLoading();
}

class ArticleSuccess extends ArticleState {
  const ArticleSuccess(this.articles);

  final List<ArticleModel> articles;

  @override
  List<Object> get props => [articles];
}

class ArticleFailure extends ArticleState {
  const ArticleFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
