import 'package:http/http.dart' as http;

class ApiService {
  final String _url = "api.themoviedb.org";

  getApiKey() {
    String _apiKey = "";
    return _apiKey;
  }

  getApiImage(String path) {
    String imageUrl = "https://image.tmdb.org/t/p/w500" + path;
    return imageUrl;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + getApiKey()
      };

  Future getApiData(String path, var param) async {
    var _fullUrl = Uri.https(_url, path, param);
    return await http.get(_fullUrl, headers: _setHeaders());
  }
}
