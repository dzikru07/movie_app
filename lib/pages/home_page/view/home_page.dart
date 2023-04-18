import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../component/error_handling/view/api_error.dart';
import '../../../component/error_handling/view/network_error.dart';
import '../../../service/api.dart';
import '../../../style/color.dart';
import '../../../style/text.dart';
import '../bloc/home_bloc_bloc.dart';
import 'list_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) =>
            HomeBlocBloc()..add(HomeGetDataEvent("/3/movie/popular")),
        child: HomePageBloc(),
      ),
    );
  }
}

class HomePageBloc extends StatefulWidget {
  const HomePageBloc({super.key});

  @override
  State<HomePageBloc> createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    HomeBlocBloc cobaListData = context.read<HomeBlocBloc>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<HomeBlocBloc, HomeBlocState>(
                    bloc: cobaListData,
                    builder: (context, state) {
                      if (state is HomeBlocSuccessState) {
                        return CarouselSlider(
                          options:
                              CarouselOptions(height: 210, viewportFraction: 1),
                          items: state.movieData.results.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/card/detail",
                                        arguments: i.id.toString());
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              ApiService()
                                                  .getApiImage(i.posterPath),
                                            ),
                                            fit: BoxFit.cover)),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  i.overview.toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: carouselTitleText,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Text(
                                                    i.title.toString(),
                                                    style: carouselSubTitleText,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      } else if (state is HomeBlocError) {
                        return ErrorApiPage(
                          message: state.message.statusMessage,
                          height: height,
                          width: width,
                        );
                      } else if (state is HomeBlocNetworkError) {
                        return ErrorNetworkPage(
                          message: state.message,
                          height: height,
                          width: width,
                        );
                      } else {
                        return SizedBox(
                          height: 210,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: appBarColorAccent,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          "Now Playing",
                          style: userTextCategoriesHome,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Top Rating",
                          style: userTextCategoriesHome,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Upcoming",
                          style: userTextCategoriesHome,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: height / 2,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        ListNewsCategory(path: "/3/movie/now_playing"),
                        ListNewsCategory(path: "/3/movie/top_rated"),
                        ListNewsCategory(path: "/3/movie/upcoming"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
