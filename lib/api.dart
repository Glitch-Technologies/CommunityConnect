/* You should import this into files that need to use the API
*  Import with `import "api.dart";`
*  Invoke with `Server.foo();`
*/ 
import 'dart:convert';
import 'package:http/http.dart' as http;

class Server {
  static bool tryConnect() {}
  static void fetchData() async {
    var response =
        await http.get(Uri.parse('http://glitchtech.top:10/search?term=tech'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
    } else {
      print('Failed to fetch data');
    }
  }
}
