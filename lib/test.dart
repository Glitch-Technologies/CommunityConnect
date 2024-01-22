import "api.dart";

Future<void> main() async {
  print(await Server.tryConnect());
  print(await Server.search("tech"));
}
