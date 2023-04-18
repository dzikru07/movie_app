part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailSuccessState extends DetailState {
  DetailsModels movieData;

  DetailSuccessState(this.movieData);
}

class DetailCreditSuccessState extends DetailState {
  CreditModels creditData;

  DetailCreditSuccessState(this.creditData);
}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {
  MovieErrorModels message;

  DetailError(this.message);
}

class DetailNetworkError extends DetailState {
  String message;

  DetailNetworkError(this.message);
}
