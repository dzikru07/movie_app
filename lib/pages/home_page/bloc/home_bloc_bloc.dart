import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/pages/home_page/models/movie_list_models.dart';

import '../models/error_movie_models.dart';
import '../view_models/home_view_models.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeGetDataEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    ServicePage servicePage = ServicePage();
    on<HomeGetDataEvent>((event, emit) async {
      // TODO: implement event handler
      emit(HomeBlocLoading());
      final data = await servicePage.getListData(event.path.toString());
      inspect(data);
      try {
        if (data.statusCode == 200) {
          MovieListModels dataList = movieListModelsFromJson(data.body);
          emit(HomeBlocSuccessState(dataList));
        } else {
          MovieErrorModels dataMessage = movieErrorModelsFromJson(data.body);
          emit(HomeBlocError(dataMessage));
        }
      } catch (e) {
        emit(HomeBlocNetworkError(e.toString()));
      }
    });
  }
}
