import 'package:dating_app/translator.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Translation extends StatefulWidget {
  final String regText;
  Translation({required this.regText});
  @override
  State<Translation> createState() => _MyAppState();
}

class _MyAppState extends State<Translation> {
  @override
  final translator = GoogleTranslator();

  String _translatedText = '';

  void translateText() {
    translator.translate(widget.regText, to: 'ta').then((value) {
      setState(() {
        _translatedText = value.text;
      });
    }).catchError((error) {
      print("Translation Error: $error");
    });
  }

  @override
  void initState() {
    super.initState();
    // Call translateText function when the page is initialized
    translateText();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('English to Tamil Translator'),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Text(
            _translatedText,
            style: const TextStyle(fontSize: 18.0),
          ),
        ));
  }
}
