import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';

import '../Home Page/home_page.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Password',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: Colors.black,
              thickness: 2,
              indent: 90,
              endIndent: 90,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1031,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Create New Password',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Please enter new password in order ')),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text("to access your account"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0644,
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6162,
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Create new password",
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "New password",
                            hintText: "Create a new password",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Confirm new password",
                            hintText: "Enter new password again",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.17,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: const Text("Save"),
                          onPressed: () {
                            Navigator.push(context,
                                FlutterScaleRoute(page: const HomePage()));
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
