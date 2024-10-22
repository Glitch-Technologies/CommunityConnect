/* You should import this into files that need to use the API
*  Import with `import "api.dart";`
*  Invoke with `Server.foo();`
*/
import 'dart:async';

import "package:http/http.dart" as http;
import 'dart:convert';

// Server class: Handles all API calls
class Server {

  // Bank of possible endpoints for server contact to ensure reliability
  static List<String> urlbank = [
    "glitchtech.top", 
    "glitchtech.chaseinator.com",
    "glitchtech.tedfullwood.com", 
    "50.115.170.113",
  ];
  static int dns = 1;

  // Base64 encodes the data parameter
  static String en(String data) {
    String encodedData = base64Url.encode(utf8.encode(data));
    return encodedData.replaceAll('=', '~');
  }

  static Future<dynamic> search(String term, Map<String, dynamic> values) async {
    String request = buildRequest("search", {"term": term, ...values}, encode: true);
    var response = await fetchData(request);
    String responseData = response.toString();
    print(responseData);
    return response;
  }

  static Future<dynamic> upload(int num, String properties) async {
    String request = buildRequest("upload", {"num": "$num", "input": properties}, encode: true);
    print(request);
    var response = await fetchData(request);
    print("$response");
    return response;
  }

  static Future<String> test() async {
    return await "true";
  }

  static Future<dynamic> tryConnectAll({bool changeDNS = false}) async {
    int finalDNS = dns;
    String result = "";
    dns = 0;
    
    for (int i = urlbank.length-1; i >= 0; i--) {
      bool t = await tryConnect();
      
      if (t) {
        result = "$result${urlbank[i]}: Connection Successful\n";
        if (changeDNS) {
          finalDNS = i;
        }
      } else {
        result = "$result${urlbank[i]}: Connection Failed\n";
      }
      
      dns++;
    }
    dns = finalDNS;
    result = "$result Active DNS=${urlbank[dns]}\n";
    return result;
  }

  static Future<bool> tryConnect() async {
      String request = buildRequest("supersecret", {});
      final response = await fetchData(request, json: false, timeout: true);
      if (response.contains("Error")) {
        return false;
      } else {
        return true;
      }
    }

  static String buildRequest(String path, Map query, {bool encode = false}) {
    String url = 'http://${urlbank[dns]}:10/$path?';
    for (int i = 0; i < query.keys.length; i++) {
      if (encode == true) {
        url = '$url${query.keys.elementAt(i)}=${en(query.values.elementAt(i))}';
      } else {
        url = '$url${query.keys.elementAt(i)}=${query.values.elementAt(i)}';
      }
      if (i + 1 < query.length) {
        url = '$url&';
      }
    }
    return url;
  }

  static Future<dynamic> fetchData(String request, {bool json = true, bool timeout = false, bool post = false}) async {
    try {
      var response;
      if (timeout) {
        response = await http.get(Uri.parse(request)).timeout(
          const Duration(seconds: 1),
          onTimeout: () {
            // Time has run out, do what you wanted to do.
            return http.Response('Error', 408); // Request Timeout response status code
          },
        );
      } else {
        response = await http.get(Uri.parse(request));
      }
      if (response.statusCode == 200) {
        dynamic data;
        if (json) {
          data = jsonDecode(response.body);
        } else {
          data = response.body;
        }
        return data;
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}