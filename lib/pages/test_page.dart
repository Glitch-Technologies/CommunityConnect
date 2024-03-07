import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
    @override
    _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
    List<String> anagrams = [];

    List<String> generateAnagrams(String word) {
        List<String> anagrams = [];
        _generateAnagramsHelper(word.split(''), 0, anagrams);
        return anagrams;
    }

    void _generateAnagramsHelper(
            List<String> word, int index, List<String> anagrams) {
        if (index == word.length - 1) {
            anagrams.add(word.join(''));
            return;
        }

        for (int i = index; i < word.length; i++) {
            List<String> newWord = List.from(word);
            String temp = newWord[index];
            newWord[index] = newWord[i];
            newWord[i] = temp;

            _generateAnagramsHelper(newWord, index + 1, anagrams);
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Test Page'),
            ),
            body: Column(
                children: [
                    TextField(
                        decoration: InputDecoration(
                            hintText: 'Search...',
                        ),
                        onChanged: (value) {
                            setState(() {
                                anagrams = generateAnagrams(value);
                            });
                        },
                    ),
                    Column(
                        children: anagrams.map((anagram) => Text(anagram)).toList(),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton.icon(
                            onPressed: () {
                                // Show help popup logic here
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                        return AlertDialog(
                                            content: Text('Help not found'),
                                        );
                                    },
                                );
                            },
                            icon: Icon(Icons.help_outline),
                            label: Text('Help'),
                        ),
                    ),
                ],
            ),
        );
    }
}