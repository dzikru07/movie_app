part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetailEvent extends DetailEvent {
  String id;

  GetDetailEvent(this.id);
}

class GetCreditEvent extends DetailEvent {
  String id;

  GetCreditEvent(this.id);
}
