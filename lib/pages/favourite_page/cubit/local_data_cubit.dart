import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/component/alert/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favourite_models.dart';

part 'local_data_state.dart';

class LocalDataCubit extends Cubit<LocalDataState> {
  LocalDataCubit() : super(LocalDataInitial());

  List<FavouriteModels> listData = [];

  getDataLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('action');
    if (action == null) {
      listData = [];
      emit(LocalDataSuccess(listData));
    } else {
      listData = favouriteModelsFromJson(action.toString());
      emit(LocalDataSuccess(listData));
    }
  }

  addDataToLocal(FavouriteModels value, BuildContext context) async {
    var data = listData.where((element) => element.id == value.id);
    if (data.isEmpty) {
      listData.add(value);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('action', jsonEncode(listData));
      AlertApp().mainSnackbar(context, "Data behasil ditambahkan");
    } else {
      AlertApp().mainSnackbar(context, "Data sudah ada");
    }
  }

  updateDataToLocal(List<FavouriteModels> value) async {
    emit(LocalDataLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('action', jsonEncode(value));
    Future.delayed(Duration(milliseconds: 1000), () {
      emit(LocalDataSuccess(listData));
    });
  }
}
