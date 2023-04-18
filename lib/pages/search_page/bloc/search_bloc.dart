import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/pages/home_page/models/error_movie_models.dart';
import 'package:movie_app/pages/search_page/models/search_models.dart';
import '../view_models/search_view_models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchInitialEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    ServiceSearchPage servicePage = ServiceSearchPage();
    on<SearchInitialEvent>((event, emit) async {
      emit(SearchLoading());
      print(12);
      final data = await servicePage.getListData(event.query.toString());
      print(12);
      try {
        if (data.statusCode == 200) {
          print(1);
          SearchModels dataList = searchModelsFromJson(data.body);
          emit(SearchDataLoaded(dataList));
        } else {
          print(2);
          MovieErrorModels dataMessage = movieErrorModelsFromJson(data.body);
          emit(SearchErrorApi(dataMessage));
        }
      } catch (e) {
        emit(SearchNetworkError(e.toString()));
      }
    });
  }
}
