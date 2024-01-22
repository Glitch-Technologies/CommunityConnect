import 'package:flutter/material.dart';
import '../assets/colors.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: midnightGreen,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: lightSkyBlue,
          child: Column(
            children: [
              const SizedBox(height: 25),
              SizedBox(
                width: 450,
                child: SearchAnchor(
                  viewConstraints: const BoxConstraints(maxHeight: 200),
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                        return List<ListTile>.generate(3, (index) { return const ListTile(title: Text("kys")); });
                      },
                ),
              ),
              Expanded(
                child: FutureBuilder<List>(
                  future: compileBusinesses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final List<Widget> data = snapshot.data as List<Widget>;
                      return SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: data,
                      ));
                    }
                    return const SizedBox(height: 25);
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class BusinessWidget extends StatelessWidget {
  final name;
  final type;
  final description;
  final resources;
  final contact;
  final image;

  const BusinessWidget(
      {super.key,
      required this.name,
      required this.type,
      required this.description,
      required this.resources,
      required this.contact,
      this.image});

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
                onPressed: () {},
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

Future<List<Widget>> compileBusinesses() async {
  var path =
      join(dirname(Platform.script.toFilePath()), 'lib', 'data', 'orgs.json');
  var input = await File(path).readAsString();
  var orgs = jsonDecode(input);

  List<Widget> businessWList = [];

  businessWList.add(const SizedBox(height: 25));

  for (var business in orgs["organizations"]) {
    businessWList.add(BusinessWidget(
        name: business["name"],
        type: business["type"],
        description:
            "This is a very big business. It is very big. It is known for its largeness and humongosity. Very big. Like super duper big, like it is just so big. AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH",
        resources: business["resources"],
        contact: business["contact"]["email"]));
    businessWList.add(const SizedBox(height: 25));
  }

  return businessWList;
}
