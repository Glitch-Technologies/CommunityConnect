/* You should import this into files that need to use the API
*  Import with `import "api.dart";`
*  Invoke with `Server.foo();`
*/
import 'dart:convert';
import 'package:http/http.dart' as http;

class Server {
  static Future<bool> tryConnect() async {
    String request = buildRequest("supersecret", {});
    print(fetchData(request, json: false));
    return false;
  }

  static String buildRequest(String path, Map query) {
    String url = 'http://glitchtech.top:10/$path?';
    for (int i = 0; i < query.keys.length; i++) {
      url = '$url${query.keys.elementAt(i)}=${query.values.elementAt(i)}';
      if (i + 1 < query.length) {
        url = '$url&';
      }
    }
    return url;
  }

  static Future<String> fetchData(String request, {bool json = true}) async {
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      dynamic data;
      if (json) {
        data = jsonDecode(response.body);
      } else {
        data = response.body;
      }
      return data;
    } else {
      return "";
    }
  }
}
