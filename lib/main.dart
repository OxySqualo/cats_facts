import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

import 'const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      title: 'Cat Fact',
      home: const CatFactScreen(),
    );
  }
}

class CatFactScreen extends StatefulWidget {
  const CatFactScreen({super.key});

  @override
  CatFactScreenState createState() => CatFactScreenState();
}

class CatFactScreenState extends State<CatFactScreen> {
  GoogleTranslator translator = GoogleTranslator();
  String _fact = '';
  String factTrans = '';

  final lang = TextEditingController();
  void transEnToRu() {
    translator.translate(_fact, to: 'ru').then((output) {
      factTrans = output.toString();
      setState(() {
        _fact = factTrans;
      });
    });
  }

  void transRuToEn() {
    translator.translate(_fact, to: 'en').then((output) {
      factTrans = output.toString();
      setState(() {
        _fact = factTrans;
      });
    });
  }

  Future<void> fetchFact() async {
    final response = await http.get(Uri.parse('https://catfact.ninja/fact'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      setState(() {
        _fact = data['fact'] as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cats Facts'),
        centerTitle: true,
        titleTextStyle: myTitleTextStyle(),
      ),
      body: _fact != ''
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: colorTuna),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _fact,
                        style: myTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    myElevatedButton(
                        function: fetchFact, text: 'Get a New Fact'),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        myElevatedButton(
                            function: transEnToRu, text: 'Translate'),
                        myElevatedButton(
                            function: transRuToEn, text: 'Translate back'),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: colorTuna,
                    radius: 128,
                    child: CircleAvatar(
                        radius: 120,
                        backgroundImage: AssetImage('assets/images/loki1.png')),
                  ),
                  const SizedBox(height: 20.0),
                  myElevatedButton(
                      function: fetchFact, text: 'Get a First Fact'),
                ],
              ),
            ),
    );
  }
}
