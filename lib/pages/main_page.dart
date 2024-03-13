// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../assets/colors.dart';
import 'dart:convert';
import "../api.dart";
import 'package:flutter/services.dart';

int businessNum = 1;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String searchTerm = "";
  String genreFilter = "";
  final searchController = SearchController();

  void openBusiness(int i) {
    businessNum = i;
    Navigator.pushNamed(
        context, "/business_page/");
  }

  Future<List<Widget>> search(String term, var open) async {
    final specialChars = RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+='"'"']');

    if (term.contains(specialChars)) {
      return Future.delayed(Duration(milliseconds: 1), () {
        return [Center(child: Text("kys"))];
      });
    }
    var orgs = await Server.search(term);
    print(orgs);
    var businessWidgets = createBusinesses(orgs, (int i) {
      open(i);
    });

    return businessWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: midnightGreen,
          title: Text(
            "CommunityConnect",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // Button logic here
                final String response = await Server.tryConnectAll(changeDNS: true);
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
          child: Column(
            children: [
              const SizedBox(height: 25),
              SizedBox(
                  width: 450,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 325,
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          onSubmitted: (value) {
                            setState(() {
                              searchTerm = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 12.5),
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                      SizedBox(width: 12.5),
                      PopupMenuButton(itemBuilder: (context) {return {"None", "Agriculture", "Art", "Construction", "Education", "Finance", "Health", "Law", "Manufacturing", "Non-Profit", "Technology"}.map((String choice) {
                        return PopupMenuItem<String>(value: choice,child: Text(choice));}).toList();
                      }
                      )
                    ],
                  )),
              const SizedBox(height: 25),
              FutureBuilder(
                  future: search(searchTerm, (int i) {
                    openBusiness(i);
                  }),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                          child: SingleChildScrollView(
                              child: Column(children: snapshot.data)));
                    } else {
                      return Text("what");
                    }
                  }),
            ],
          )),
    );
  }
}

class BusinessWidget extends StatelessWidget {
  final int number;
  final String name;
  final String type;
  final String description;
  final String resources;
  final String contact;
  final Image? image;
  final onPressed;

  BusinessWidget({
    super.key,
    required this.number,
    required this.name,
    required this.type,
    required this.description,
    required this.resources,
    required this.contact,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 450,
            height: 250,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: verdigris,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                onPressed: () {
                  onPressed(number);
                },
                child: SizedBox(
                    height: 220,
                    width: 430,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: richBlack, fontSize: 20),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 20,
                          child: Text(
                            type,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: richBlack, fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 60,
                          child: Text(
                            description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: richBlack),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 20,
                          child: Text(
                            "Resources: $resources",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: richBlack),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 20,
                          child: Text(
                            "Contact Info: $contact",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: richBlack),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    )))));
  }
}

compileBusinesses(var open) async {
  var input = await rootBundle.loadString('assets/orgs.json');
  var orgs = await jsonDecode(input);
  return createBusinesses(orgs, (int i) {
    open(i);
  });
}

Future<List<Widget>> createBusinesses(var orgs, var open) async {
  List<Widget> businessWList = [];

  //server json does not have numbers
  for (var business in orgs["return"]["matches"]) {
    businessWList.add(BusinessWidget(
        number: business["number"],
        name: business["name"],
        type: business["type"],
        description: business["description"],
        resources: business["resources"],
        contact: business["contact"]["email"],
        onPressed: (int i) {
          open(i);
        }));
    businessWList.add(const SizedBox(height: 25));
  }
  print(businessWList);
  return businessWList;
}
