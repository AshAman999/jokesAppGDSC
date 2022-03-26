import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JokesPage extends StatefulWidget {
  const JokesPage({Key? key}) : super(key: key);

  @override
  State<JokesPage> createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  String joke = 'No joke yet';
  @override
  void initState() {
    getJoke();
    super.initState();
  }

  void getJoke() async {
    try {
      var response = await http
          .get(Uri.parse('https://v2.jokeapi.dev/joke/Any?type=single'));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var apijoke = body['joke'];
        setState(
          () {
            joke = apijoke;
          },
        );
      } else {
        setState(() {
          joke = 'Error';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Jokes App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(joke),
              ),
              SizedBox(
                height: 40,
              ),
              CupertinoButton.filled(
                child: Text("Get Joke"),
                onPressed: () {
                  getJoke();
                },
              )
            ],
          ),
        ));
  }
}
