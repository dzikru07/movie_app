part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitialEvent extends SearchEvent {
  String query;

  SearchInitialEvent(this.query);
}
