import "api.dart";
import "package:http/http.dart" as http;


Future<void> main() async {
  //print(await Server.tryConnect());
  print(await Server.search("tech"));
  //String formattedResponse = await Server.tryConnect().then((value) => value.toString());
  //print(formattedResponse);
  //print(Server.en("abcd"));
  //final response = await http.get(Uri.parse('http://glitchtech.tedfullwood.com:10'));
  //print(response.statusCode);
}
