import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movie_app/service/api.dart';
import '../../../component/error_handling/view/api_error.dart';
import '../../../component/error_handling/view/network_error.dart';
import '../../../component/format/time_format.dart';
import '../../../style/color.dart';
import '../../favourite_page/cubit/local_data_cubit.dart';
import '../../favourite_page/models/favourite_models.dart';
import '../bloc/home_bloc_bloc.dart';

class ListNewsCategory extends StatelessWidget {
  ListNewsCategory({super.key, required this.path});

  String path;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBlocBloc()..add(HomeGetDataEvent(path)),
          ),
          BlocProvider(
            create: (context) => LocalDataCubit(),
          ),
        ],
        child: ListNewsCategoryBloc(),
      ),
    );
  }
}

class ListNewsCategoryBloc extends StatefulWidget {
  const ListNewsCategoryBloc({super.key});

  @override
  State<ListNewsCategoryBloc> createState() => _ListNewsCategoryBlocState();
}

class _ListNewsCategoryBlocState extends State<ListNewsCategoryBloc>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> animated;

  int dataFav = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    animated = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    context.read<LocalDataCubit>().getDataLocal();
  }

  runAnimationControllerShow() async {
    _controller.repeat();
    await _controller.forward();
    await Future.delayed(const Duration(
      milliseconds: 600,
    ));
    _controller.reset();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeBlocBloc movieCatBloc = context.read<HomeBlocBloc>();

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeBlocBloc, HomeBlocState>(
      bloc: movieCatBloc,
      builder: (context, state) {
        if (state is HomeBlocSuccessState) {
          return AnimationLimiter(
            child: ListView.builder(
                itemCount: state.movieData.results.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: Duration(milliseconds: 100),
                      child: SlideAnimation(
                          duration: Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                              duration: Duration(milliseconds: 2500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pushNamed(context, "/card/detail",
                                      arguments: state
                                          .movieData.results[index].id
                                          .toString());
                                },
                                onDoubleTap: () async {
                                  setState(() {
                                    dataFav = index;
                                  });
                                  context.read<LocalDataCubit>().addDataToLocal(
                                      FavouriteModels(
                                        adult: state
                                            .movieData.results[index].adult,
                                        backdropPath: state.movieData
                                            .results[index].backdropPath,
                                        genreIds: state
                                            .movieData.results[index].genreIds,
                                        id: state.movieData.results[index].id,
                                        originalLanguage: state.movieData
                                            .results[index].originalLanguage,
                                        originalTitle: state.movieData
                                            .results[index].originalTitle,
                                        overview: state
                                            .movieData.results[index].overview,
                                        popularity: state.movieData
                                            .results[index].popularity,
                                        posterPath: state.movieData
                                            .results[index].posterPath,
                                        releaseDate: state.movieData
                                            .results[index].releaseDate
                                            .toString(),
                                        title: state
                                            .movieData.results[index].title,
                                        video: state
                                            .movieData.results[index].video,
                                        voteAverage: state.movieData
                                            .results[index].voteAverage,
                                        voteCount: state
                                            .movieData.results[index].voteCount,
                                      ),
                                      context);
                                  runAnimationControllerShow();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(
                                      top: 15, left: 8, right: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 141, 141, 141)
                                                  .withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(
                                            height: 110,
                                            width: 110,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        ApiService()
                                                            .getApiImage(state
                                                                .movieData
                                                                .results[index]
                                                                .posterPath)),
                                                    fit: BoxFit.cover)),
                                          ),
                                          dataFav == index
                                              ? ScaleTransition(
                                                  scale: animated,
                                                  child: Icon(
                                                    Icons.favorite,
                                                    size: 45,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: _width / 1.9,
                                            child: Text(
                                              state.movieData.results[index]
                                                  .title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: cardTitleColor),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: _width / 1.9,
                                            child: Text(
                                              state.movieData.results[index]
                                                  .overview
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: cardSubTitleColor),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            width: _width / 1.9,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: cardDateColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      FormatData()
                                                          .getDataFormat(state
                                                              .movieData
                                                              .results[index]
                                                              .releaseDate),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: cardAuthorColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      state
                                                          .movieData
                                                          .results[index]
                                                          .popularity
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))));
                }),
          );
        } else if (state is HomeBlocError) {
          return ErrorApiPage(
            message: state.message.statusMessage,
            height: _height,
            width: _width,
          );
        } else if (state is HomeBlocNetworkError) {
          return ErrorNetworkPage(
            message: state.message,
            height: _height,
            width: _width,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
