import 'package:http/http.dart' as http;
import '../../../service/api.dart';

class ServiceSearchPage {
  ApiService _apiService = ApiService();

  getListData(String query) async {
    var param = {
      "language": "en-US",
      "api_key": _apiService.getApiKey(),
      "query": query
    };

    print(param);

    try {
      http.Response response =
          await _apiService.getApiData("/3/search/movie", param);
      return response;
    } catch (e) {
      return e;
    }
  }
}
