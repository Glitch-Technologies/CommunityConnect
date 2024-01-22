import 'package:flutter/material.dart';
import '../assets/colors.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

bool isAdmin = false;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final userCont = TextEditingController();
  final passCont = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userCont.dispose();
    passCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
              child: Text(
            "",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
          backgroundColor: midnightGreen),
      body: Container(
        color: lightSkyBlue,
        child: Center(
            child: Container(
          width: 400,
          height: 250,
          decoration: BoxDecoration(
            color: verdigris,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                "Community Connect Login",
                style: TextStyle(fontSize: 24),
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: SizedBox(
                    height: 40,
                    child: TextField(
                        controller: userCont,
                        cursorColor: richBlack,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: richBlack)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: richBlack),
                            )))),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: SizedBox(
                    height: 20,
                    child: Text(
                      "username",
                      softWrap: false,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    obscureText: true,
                      controller: passCont,
                      cursorColor: richBlack,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: richBlack)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: richBlack),
                        ),
                      )),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Text("password"),
              ),
              const SizedBox(height: 15),
              Center(
                  child: ElevatedButton(
                onPressed: () async {
                  bool isLoggedIn = await login(userCont.text, passCont.text);
                  if (isLoggedIn) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(context, "/main_page/", (Route route) => false);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(electricBlue)),
                child: Text("Log In", style: TextStyle(color: richBlack)),
              ))
            ],
          ),
        )),
      ),
    );
  }
}

Future<bool> login(String user, String pass) async {
  //var path = join(dirname(Platform.script.toFilePath()), 'lib', 'data', 'users.json');
  //var input = await File(path).readAsString();
  var input = rootBundle.loadString('assets/users.json');
  //var users = jsonDecode(input);
  var users = await jsonDecode(input);
  for (var i = 0; i < users.length; i++) {
    if (users[i][0] == user) {
      if (users[i][1] == pass) {
        isAdmin = users[i][2];
        return true;
      }
    }
  }
  return false;
}
