import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../../service/api.dart';

class ServiceDetailPage {
  ApiService _apiService = ApiService();

  getListData(String id) async {
    var param = {
      "api_key": _apiService.getApiKey(),
    };

    try {
      http.Response response =
          await _apiService.getApiData('/3/movie/' + id, param);
      return response;
    } catch (e) {
      return e;
    }
  }

  getCreditData(String id) async {
    var param = {
      "api_key": _apiService.getApiKey(),
    };

    try {
      http.Response response =
          await _apiService.getApiData('/3/movie/' + id + "/credits", param);
      return response;
    } catch (e) {
      return e;
    }
  }
}
