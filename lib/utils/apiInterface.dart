import 'package:http/http.dart' as http;

Future<String> testGet(String userToken) async {
  var headers = {
    "authorization": userToken
  };

  var url = Uri.parse('https://time-travel-bp.herokuapp.com/', );
  var response = await http.get(url, headers: headers);
  
  return response.body;
}

Future<String> getMonuments(String userToken) async {
  var headers = {
    "authorization": userToken
  };

  var url = Uri.parse('https://time-travel-bp.herokuapp.com/monuments/all', );
  var response = await http.get(url, headers: headers);

  return response.body;
}