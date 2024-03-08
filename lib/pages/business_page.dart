import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../assets/colors.dart';
import 'main_page.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  @override
  Widget build(BuildContext context) {
    var businessDic;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: midnightGreen,
            title: Text("CommunityConnect"),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.question_mark, color: richBlack),
                  tooltip: "Help"),
              SizedBox(width: 75),
            ]),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: lightSkyBlue,
          child: Center(
              child: SizedBox(
            width: 500,
            height: 500,
            child: Container(
              decoration: BoxDecoration(
                color: verdigris,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: FutureBuilder(
                future: compileBusiness(businessNum),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    businessDic = snapshot.data;
                    var resources = businessDic["resources"];
                    var contact = businessDic["contact"]["email"];
                    return Center(
                      child: SizedBox(
                        height: 440,
                        width: 460,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Text(
                                businessDic["name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: richBlack, fontSize: 40),
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
                                style: TextStyle(color: richBlack, fontSize: 25),
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
                                style: TextStyle(color: richBlack, fontSize: 18),
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
                                style: TextStyle(color: richBlack, fontSize: 18),
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
                                style: TextStyle(color: richBlack, fontSize: 18),
                                textAlign: TextAlign.start,
                              ),
                            )
                          ],
                        )),
                    );
                  }
                  return SizedBox();
                }
              ))
            ),
          )),
        ));
  }
}

compileBusiness(int i) async {
  var input = await rootBundle.loadString('assets/orgs.json');
  var orgs = await jsonDecode(input);
  return orgs["organizations"][i-1];
}