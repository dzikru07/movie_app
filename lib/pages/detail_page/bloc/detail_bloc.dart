import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/pages/detail_page/models/credit_models.dart';
import 'package:movie_app/pages/detail_page/models/detail_models.dart';

import '../../home_page/models/error_movie_models.dart';
import '../view_models/home_view_models.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<GetDetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    ServiceDetailPage servicePage = ServiceDetailPage();

    on<GetDetailEvent>((event, emit) async {
      emit(DetailLoading());
      final data = await servicePage.getListData(event.id.toString());
      try {
        if (data.statusCode == 200) {
          DetailsModels dataList = detailsModelsFromJson(data.body);
          emit(DetailSuccessState(dataList));
        } else {
          MovieErrorModels dataMessage = movieErrorModelsFromJson(data.body);
          emit(DetailError(dataMessage));
        }
      } catch (e) {
        emit(DetailNetworkError(e.toString()));
      }
    });
  }
}

class CreditBloc extends Bloc<GetCreditEvent, DetailState> {
  CreditBloc() : super(DetailInitial()) {
    ServiceDetailPage servicePage = ServiceDetailPage();

    on<GetCreditEvent>((event, emit) async {
      emit(DetailLoading());
      final data = await servicePage.getCreditData(event.id.toString());
      try {
        if (data.statusCode == 200) {
          CreditModels dataList = creditModelsFromJson(data.body);
          emit(DetailCreditSuccessState(dataList));
        } else {
          MovieErrorModels dataMessage = movieErrorModelsFromJson(data.body);
          emit(DetailError(dataMessage));
        }
      } catch (e) {
        emit(DetailNetworkError(e.toString()));
      }
    });
  }
}
