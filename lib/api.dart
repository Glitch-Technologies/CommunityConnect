/* You should import this into files that need to use the API
*  Import with `import "api.dart";`
*  Invoke with `Server.foo();`
*/
import 'dart:convert';

static String encode(String data) {
  String encodedData = base64Url.encode(utf8.encode(data));
  return encodedData.replaceAll('=', '~');
}
  //TODO: Write encode operation in dart. See server/main.py:encode
  static String encode(String data) {
    
  }

  static Future<dynamic> search(String term) async {
    String request = buildRequest("search", {"term": term});
    var response = await fetchData(request);
    return response;
  }

  static Future<bool> test() async {
    return await true;
  }

  static Future<bool> tryConnect() async {
    String request = buildRequest("supersecret", {});
    var response = await fetchData(request, json: false).timeout(
        Duration(seconds: 5),
        onTimeout: () => throw TimeoutException("timeout"));
    if (response is TimeoutException) {
      return false;
    } else {
      return true;
    }
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

  static Future<dynamic> fetchData(String request, {bool json = true}) async {
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
