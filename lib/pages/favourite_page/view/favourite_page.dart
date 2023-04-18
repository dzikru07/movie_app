import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_app/service/api.dart';
import 'package:unicons/unicons.dart';

import '../../../component/error_handling/view/empty_list.dart';
import '../../../style/color.dart';
import '../../../style/text.dart';
import '../cubit/local_data_cubit.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => LocalDataCubit(),
        child: FavouritePageBloc(),
      ),
    );
  }
}

class FavouritePageBloc extends StatefulWidget {
  const FavouritePageBloc({super.key});

  @override
  State<FavouritePageBloc> createState() => _FavouritePageBlocState();
}

class _FavouritePageBlocState extends State<FavouritePageBloc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LocalDataCubit>().getDataLocal();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LocalDataCubit, LocalDataState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LocalDataSuccess) {
              if (state.listData.isEmpty) {
                return Center(
                  child: EmptyListPage(
                      message: "No Data Has Been Saved",
                      height: _height,
                      width: _width),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Watchlist Movie', style: pageTitle),
                      AnimationLimiter(
                        child: ListView.builder(
                            itemCount: state.listData.length,
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
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/card/detail",
                                            arguments: state.listData[index].id
                                                .toString());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        margin: EdgeInsets.only(
                                            top: 15, left: 8, right: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                        255, 141, 141, 141)
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
                                              children: [
                                                Container(
                                                  height: 110,
                                                  width: 110,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              ApiService()
                                                                  .getApiImage(state
                                                                      .listData[
                                                                          index]
                                                                      .posterPath
                                                                      .toString())),
                                                          fit: BoxFit.cover)),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    state.listData
                                                        .removeAt(index);
                                                    context
                                                        .read<LocalDataCubit>()
                                                        .updateDataToLocal(
                                                            state.listData);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        12)),
                                                        color: Colors.white
                                                            .withOpacity(0.6)),
                                                    child: Icon(
                                                      UniconsLine.trash,
                                                      size: 20,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
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
                                                  width: _width / 1.8,
                                                  child: Text(
                                                    state.listData[index].title
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: titleListCategory,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  width: _width / 1.8,
                                                  child: Text(
                                                    state.listData[index]
                                                        .overview
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: subTitleListCategory,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                SizedBox(
                                                  width: _width / 1.8,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  cardDateColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Text(
                                                            state
                                                                .listData[index]
                                                                .releaseDate
                                                                .toString(),
                                                            style:
                                                                dateListCategory,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  cardAuthorColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Text(
                                                            state
                                                                .listData[index]
                                                                .popularity
                                                                .toString(),
                                                            style:
                                                                dateListCategory,
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
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
