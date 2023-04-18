import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/pages/favourite_page/cubit/local_data_cubit.dart';
import 'package:movie_app/pages/favourite_page/models/favourite_models.dart';
import 'package:movie_app/service/api.dart';
import 'package:unicons/unicons.dart';

import '../../../component/error_handling/view/api_error.dart';
import '../../../component/error_handling/view/network_error.dart';
import '../../../component/format/time_format.dart';
import '../../../style/color.dart';
import '../../../style/text.dart';
import '../bloc/detail_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage({super.key, required this.id});

  String id;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DetailBloc()..add(GetDetailEvent(id)),
          ),
          BlocProvider(
            create: (context) => CreditBloc()..add(GetCreditEvent(id)),
          ),
          BlocProvider(
            create: (context) => LocalDataCubit(),
          ),
        ],
        child: MovieDetailBloc(),
      ),
    );
  }
}

class MovieDetailBloc extends StatefulWidget {
  MovieDetailBloc({super.key});

  @override
  State<MovieDetailBloc> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<MovieDetailBloc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LocalDataCubit>().getDataLocal();
  }

  @override
  Widget build(BuildContext context) {
    //bloc moview
    DetailBloc movieDetailBloc = context.read<DetailBloc>();
    CreditBloc creditDetailBloc = context.read<CreditBloc>();
    //-------------------------------------------------------------
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailSuccessState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: _height / 2.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    ApiService().getApiImage(
                                        state.movieData.posterPath),
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(8, 4, 20, 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withOpacity(0.5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    UniconsLine.arrow_left,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Detail',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    FormatData().getDataFormat(
                                        state.movieData.releaseDate),
                                    style: subTitleListCategory,
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<LocalDataCubit>().addDataToLocal(
                                      FavouriteModels(
                                        adult: state.movieData.adult,
                                        backdropPath:
                                            state.movieData.backdropPath,
                                        genreIds: [],
                                        id: state.movieData.id,
                                        originalLanguage:
                                            state.movieData.originalLanguage,
                                        originalTitle:
                                            state.movieData.originalTitle,
                                        overview: state.movieData.overview,
                                        popularity: state.movieData.popularity,
                                        posterPath: state.movieData.posterPath,
                                        releaseDate: state.movieData.releaseDate
                                            .toString(),
                                        title: state.movieData.title,
                                        video: state.movieData.video,
                                        voteAverage:
                                            state.movieData.voteAverage,
                                        voteCount: state.movieData.voteCount,
                                      ),
                                      context);
                                  ;
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Add To Watchlist',
                                        style: dateListCategory,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        UniconsLine.bookmark,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.movieData.title,
                            style: detailMovieTextTitle,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            state.movieData.overview,
                            style: subTitleListCategory,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            'Credit',
                            style: navigationTextHome,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<CreditBloc, DetailState>(
                            builder: (context, state2) {
                              if (state2 is DetailCreditSuccessState) {
                                return SizedBox(
                                  height: 220,
                                  child: ListView.builder(
                                      itemCount: state2.creditData.cast.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(right: 15),
                                          width: 100,
                                          child: SingleChildScrollView(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: DecorationImage(
                                                            image: NetworkImage(ApiService()
                                                                .getApiImage(state2
                                                                    .creditData
                                                                    .cast[index]
                                                                    .profilePath
                                                                    .toString())),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    state2.creditData
                                                        .cast[index].name
                                                        .toString(),
                                                    style: navigationTextHome,
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    state2.creditData
                                                        .cast[index].character
                                                        .toString(),
                                                    style: subTitleListCategory,
                                                  )
                                                ]),
                                          ),
                                        );
                                      }),
                                );
                              } else if (state2 is DetailError) {
                                return ErrorApiPage(
                                  message: state2.message.statusMessage,
                                  height: _height,
                                  width: _width,
                                );
                              } else if (state2 is DetailNetworkError) {
                                return ErrorNetworkPage(
                                  message: state2.message,
                                  height: _height,
                                  width: _width,
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is DetailError) {
              return ErrorApiPage(
                message: state.message.statusMessage,
                height: _height,
                width: _width,
              );
            } else if (state is DetailNetworkError) {
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
        ),
      ),
    );
  }
}
