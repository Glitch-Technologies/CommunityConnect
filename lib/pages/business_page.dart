import 'dart:convert';

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
          child: Row(
            children: [
              Expanded(child: SizedBox()),
              Center(
                  child: FutureBuilder(
                      future: compileBusiness(businessNum),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          businessDic = snapshot.data;
                          var resources = businessDic["resources"];
                          var contact = businessDic["contact"]["email"];
                          if (!isEditable) {
                            return Center(
                              child: SizedBox(
                                height: 500,
                                width: 500,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: verdigris,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        height: 440,
                                        width: 460,
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
                                                    color: richBlack, fontSize: 40),
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
                                                    color: richBlack, fontSize: 25),
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
                                                    color: richBlack, fontSize: 18),
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
                                                    color: richBlack, fontSize: 18),
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
                                                    color: richBlack, fontSize: 18),
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
                            TextEditingController nameCont = TextEditingController(text: businessDic["name"]);
                            TextEditingController typeCont = TextEditingController(text: businessDic["type"]);
                            TextEditingController descriptionCont = TextEditingController(text: businessDic["description"]);
                            TextEditingController resourcesCont = TextEditingController(text: businessDic["resources"]);
                            TextEditingController contactCont = TextEditingController(text: businessDic["contact"]["email"]);
                            return Column(
                              children: [
                                SizedBox(height: 15,),
                                SizedBox(
                                  height: 500,
                                  width: 500,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: verdigris,
                                      borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    child: Center(
                                        child: SizedBox(
                                      height: 440,
                                      width: 460,
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
                                                hintText: businessDic["description"],
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
                                                hintText: businessDic["resources"],
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
                                      child: ElevatedButton(onPressed: () {saveChanges(businessNum, [nameCont.text, typeCont.text, descriptionCont.text, resourcesCont.text, contactCont.text]);}, style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(electricBlue), foregroundColor: MaterialStatePropertyAll(richBlack)), child: const Text("Save Changes"),),
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
                          onPressed: () {changeEdit();},
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

compileBusiness(int i) async {
  var input = await rootBundle.loadString('assets/orgs.json');
  var orgs = await jsonDecode(input);
  return orgs["organizations"][i - 1];
}

saveChanges(int num, List<String> properties) async {
  var input = await rootBundle.loadString('assets/orgs.json');
  var orgs = await jsonDecode(input);

  orgs["organizations"][num - 1]["name"] = properties[0];
  orgs["organizations"][num - 1]["type"] = properties[1];
  orgs["organizations"][num - 1]["description"] = properties[2];
  orgs["organizations"][num - 1]["resources"] = properties[3];
  orgs["organizations"][num - 1]["contact"]["email"] = properties[4];

  print(orgs);
}
