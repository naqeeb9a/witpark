import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String _mySelection;

  final String url = "http://witpark.pythonanywhere.com/API/AllCities_API/";

  // ignore: deprecated_member_use
  List data = []; //edited line

  Future<String> getSWData() async {
    var res =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    if (kDebugMode) {
      print(resBody);
    }

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Management"),
      ),
      body: Center(
        child: DropdownButton(
          items: data.map((item) {
            return DropdownMenuItem(
              value: item['id'].toString(),
              child: Text(item['city_name']),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal!;
            });
          },
          value: _mySelection,
        ),
      ),
    );
  }
}
