import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../../service/api.dart';

class ServicePage {
  ApiService _apiService = ApiService();

  getListData(String path) async {
    var param = {
      "language": "en-US",
      "api_key": _apiService.getApiKey(),
    };

    try {
      http.Response response = await _apiService.getApiData(path, param);
      return response;
    } catch (e) {
      return e;
    }
  }
}
