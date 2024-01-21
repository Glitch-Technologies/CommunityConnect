import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  fetchData();
}

void fetchData() async {
  var response = await http.get(Uri.parse('https://glitchtech.top:10/supersecret'));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
  } else {
    print('Failed to fetch data');
  }
}