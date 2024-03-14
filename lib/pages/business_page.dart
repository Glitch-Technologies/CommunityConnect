// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api.dart';
import '../assets/colors.dart';
import 'main_page.dart';
import "../api.dart";

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  bool isEditable = false;

  changeEdit() {
    isEditable = !isEditable;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var businessDic;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: midnightGreen,
            title: Text("CommunityConnect", style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(
                onPressed: () async {
                  // Button logic here
                  final String response =
                      await Server.tryConnectAll(changeDNS: true);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("$response"),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.flash_on,
                  color: electricBlue,
                ),
                tooltip: "Ping Server",
              ),
              IconButton(
                  onPressed: () async {
                    // Show help popup logic here
                    var helpmessage =
                        await rootBundle.loadString('assets/helpbusiness.txt');
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(helpmessage),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.help_outline,
                    color: electricBlue,
                  ),
                  tooltip: "Help"),
              SizedBox(width: 75),
            ]),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: lightSkyBlue,
          child: Row(
            children: [
              Expanded(child: SizedBox()),
              Center(
                  child: FutureBuilder(
                      future: Server.search("$businessNum", {}),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          var temp = snapshot.data;
                          businessDic = temp["return"]["matches"][0];
                          var resources = businessDic["resources"];
                          var contact = businessDic["contact"]["email"];
                          print(contact);
                          if (!isEditable) {
                            return Center(
                              child: SizedBox(
                                height: 500,
                                width: 800,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: verdigris,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        height: 440,
                                        width: 760,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              child: Text(
                                                businessDic["name"],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: richBlack,
                                                    fontSize: 40),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: Text(
                                                businessDic["type"],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: richBlack,
                                                    fontSize: 25),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            const SizedBox(height: 60),
                                            SizedBox(
                                              height: 120,
                                              child: Text(
                                                businessDic["description"],
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: richBlack,
                                                    fontSize: 18),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            SizedBox(
                                              height: 60,
                                              child: Text(
                                                "Resources: $resources",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: richBlack,
                                                    fontSize: 18),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            SizedBox(
                                              height: 40,
                                              child: Text(
                                                "Contact Info: $contact",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: richBlack,
                                                    fontSize: 18),
                                                textAlign: TextAlign.start,
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            TextEditingController nameCont =
                                TextEditingController(
                                    text: businessDic["name"]);
                            TextEditingController typeCont =
                                TextEditingController(
                                    text: businessDic["type"]);
                            TextEditingController descriptionCont =
                                TextEditingController(
                                    text: businessDic["description"]);
                            TextEditingController resourcesCont =
                                TextEditingController(
                                    text: businessDic["resources"]);
                            TextEditingController contactCont =
                                TextEditingController(
                                    text: businessDic["contact"]["email"]);
                            return Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 500,
                                  width: 800,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: verdigris,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Center(
                                        child: SizedBox(
                                      height: 440,
                                      width: 760,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 60,
                                            child: TextField(
                                              controller: nameCont,
                                              decoration: InputDecoration(
                                                hintText: businessDic["name"],
                                              ),
                                              style: TextStyle(
                                                fontSize: 40,
                                                color: richBlack,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            height: 40,
                                            child: TextField(
                                              controller: typeCont,
                                              decoration: InputDecoration(
                                                hintText: businessDic["type"],
                                              ),
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: richBlack,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 60,
                                          ),
                                          SizedBox(
                                            height: 120,
                                            child: TextField(
                                              controller: descriptionCont,
                                              decoration: InputDecoration(
                                                hintText:
                                                    businessDic["description"],
                                              ),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: richBlack,
                                              ),
                                              maxLines: 5,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: 60,
                                            child: TextField(
                                              controller: resourcesCont,
                                              decoration: InputDecoration(
                                                hintText:
                                                    businessDic["resources"],
                                              ),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: richBlack,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: TextField(
                                              controller: contactCont,
                                              decoration: InputDecoration(
                                                hintText: businessDic["contact"]
                                                    ["email"],
                                              ),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: richBlack,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          saveChanges(businessNum, {
                                            "name": nameCont.text,
                                            "type": typeCont.text,
                                            "description": descriptionCont.text,
                                            "resources": resourcesCont.text,
                                            "contact": {
                                              "email": contactCont.text
                                            }
                                          });
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    electricBlue),
                                            foregroundColor:
                                                MaterialStatePropertyAll(
                                                    richBlack)),
                                        child: const Text("Save Changes"),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        }
                        return SizedBox();
                      }))),
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        IconButton(
                          onPressed: () {
                            changeEdit();
                          },
                          icon: Icon(
                            Icons.edit,
                            color: richBlack,
                          ),
                          tooltip: "Edit",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

saveChanges(int num, Map<String, dynamic> properties) async {
  print('$num');
  print('$properties');
  
  String jsonProperties = jsonEncode(properties);
  print(jsonProperties);
  await Server.upload(num, jsonProperties);
}
