/* You should import this into files that need to use the API
*  Import with `import "api.dart";`
*  Invoke with `Server.foo();`
*/
import 'dart:async';

import "package:http/http.dart" as http;
import 'dart:convert';

class Server {
  static Future<dynamic> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static String encode(String data) {
    String encodedData = base64Url.encode(utf8.encode(data));
    return encodedData.replaceAll('=', '~');
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