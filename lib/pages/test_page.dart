import 'package:flutter/material.dart';
import '../assets/colors.dart';
import 'dart:convert';
import "../api.dart";
import 'package:flutter/services.dart';

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
                backgroundColor: midnightGreen,
                title: Text('Main Page'),
            ),
            body: Container(
                width: double.infinity,
                height: double.infinity,
                color: lightSkyBlue,
                child: Column(
                    children: [
                        Center(
                            child: Padding(
                                padding: EdgeInsets.only(top: 16, bottom: 8),
                                child: SizedBox(
                                    width: 200,
                                    child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            hintText: 'Search...',
                                            hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            ),
                                        ),
                                        onChanged: (value) {
                                            setState(() {
                                                anagrams = generateAnagrams(value);
                                            });
                                        },
                                    ),
                                ),
                            ),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                                    children: anagrams.map((anagram) => Container(
                                        margin: EdgeInsets.symmetric(vertical: 4),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.black),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(anagram),
                                        ),
                                    )).toList(),
                                ),
                            ),
                        ),
                        Stack(
                            children: [
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                        padding: EdgeInsets.only(bottom: 10, left: 10),
                                        child: ElevatedButton.icon(
                                            onPressed: () async {
                                                // Button logic here
                                                //String formattedResponse = await Server.tryConnect().then((value) => value.toString());
                                                String response = await Server.tryConnect().then((value) => value.toString());
                                                return await showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                        return AlertDialog(
                                                            content: Text(response),
                                                        );
                                                    },
                                                );
                                            },
                                            icon: Icon(Icons.flash_on),
                                            label: Text('Connection Test'),
                                        ),
                                    ),
                                ),      
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(bottom: 10, right: 10),
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
                                ),
                            ]
                        ),
                    ],
                ),
            ),  
        );  
    }   
}   