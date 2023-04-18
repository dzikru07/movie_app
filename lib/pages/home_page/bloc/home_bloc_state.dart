part of 'home_bloc_bloc.dart';

class HomeBlocState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeBlocInitial extends HomeBlocState {}

class HomeBlocSuccessState extends HomeBlocState {
  MovieListModels movieData;

  HomeBlocSuccessState(this.movieData);
}

class HomeBlocLoading extends HomeBlocState {}

class HomeBlocError extends HomeBlocState {
  MovieErrorModels message;

  HomeBlocError(this.message);
}

class HomeBlocNetworkError extends HomeBlocState {
  String message;

  HomeBlocNetworkError(this.message);
}
