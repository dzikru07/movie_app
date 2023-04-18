part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchDataLoaded extends SearchState {
  SearchModels searchData;

  SearchDataLoaded(this.searchData);
}

class SearchLoading extends SearchState {}

class SearchErrorApi extends SearchState {
  MovieErrorModels errorData;

  SearchErrorApi(this.errorData);
}

class SearchNetworkError extends SearchState {
  String message;

  SearchNetworkError(this.message);
}
