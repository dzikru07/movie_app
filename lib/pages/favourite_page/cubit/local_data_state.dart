part of 'local_data_cubit.dart';

abstract class LocalDataState extends Equatable {
  const LocalDataState();

  @override
  List<Object> get props => [];
}

class LocalDataInitial extends LocalDataState {}

class LocalDataSuccess extends LocalDataState {
  List<FavouriteModels> listData;

  LocalDataSuccess(this.listData);

  @override
  List<Object> get props => [listData];
}

class LocalDataLoading extends LocalDataState {}

class SuccessChangeData extends LocalDataState {}
