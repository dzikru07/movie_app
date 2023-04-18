part of 'home_bloc_bloc.dart';

class HomeBlocEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeGetDataEvent extends HomeBlocEvent {
  String path;

  HomeGetDataEvent(this.path);
}
