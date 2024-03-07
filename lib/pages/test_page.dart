import 'package:flutter/material.dart';
import '../assets/colors.dart';
import '../widgets/search_bar.dart'; // Added import statement for SearchBar widget
import "../api.dart";
import 'package:flutter/services.dart';

class TestPage extends StatefulWidget {
    const TestPage({Key? key}) : super(key: key);

    @override
    State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: Text('Search Example'),
                ),
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            SearchBar(),
                            SizedBox(height: 20),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: SearchBar().searchResults.length,
                                    itemBuilder: (context, index) {
                                        return ListTile(
                                            title: Text(SearchBar().searchResults[index]),
                                        );
                                    },
                                ),
                            ),
                        ],
                    ),
                ),
                floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        FloatingActionButton(
                            onPressed: () {},
                            child: Icon(Icons.help),
                        ),
                        SizedBox(height: 16),
                        FloatingActionButton(
                            onPressed: () {},
                            child: Icon(Icons.bolt),
                        ),
                        FloatingActionButton(
                            onPressed: () {
                                showHelpDialog(context);
                            },
                            child: Icon(Icons.help),
                        ),
                    ],
                ),
            ),
        );
    }
}

class SearchBar extends StatefulWidget {
    @override
    _SearchBarState createState() => _SearchBarState();

    List<String> get searchResults => _SearchBarState().searchResults;
}

class _SearchBarState extends State<SearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
            ),
            child: Row(
                children: [
                    Expanded(
                        child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                            ),
                            onChanged: (value) {
                                setState(() {
                                    searchResults = generateSearchResults(value);
                                });
                            },
                        ),
                    ),
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                            setState(() {
                                searchResults = generateSearchResults(_controller.text);
                            });
                        },
                    ),
                ],
            ),
        );
    }

    List<String> generateSearchResults(String query) {
        // Generate some dummy search results based on the query
        return List.generate(10, (index) => 'Result $index: $query');
    }

    List<String> searchResults = [];
}

void showHelpDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Help'),
                content: Text('Help not found'),
                actions: [
                    TextButton(
                        child: Text('OK'),
                        onPressed: () {
                            Navigator.of(context).pop();
                        },
                    ),
                ],
            );
        },
    );
}