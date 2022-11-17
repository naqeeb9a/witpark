import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:witpark/MVVM/Views/Profile/edit_profile.dart';
import 'package:http/http.dart' as http;

class Editpassword extends StatefulWidget {
  const Editpassword({super.key});

  @override
  State<Editpassword> createState() => _EditpasswordState();
}

class _EditpasswordState extends State<Editpassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    updatePassword();
    // Navigator.pop(context);
  }

  updatePassword() async {
    await http
        .post(
            Uri.parse(
                "https://witpark.pythonanywhere.com/API/Update_Password_API/"),
            body: data)
        .then((value) {
      var jsondata = jsonDecode(value.body);
      if (kDebugMode) {
        print(jsondata);
      }
      if (jsondata["message"] == "Invalid data") {
        showToast("wrong old password", context: context);
      } else if (jsondata["status"] == 202) {
        showToast("Successfully updated", context: context);
        Navigator.pop(context);
      } else {
        showToast("something went wrong", context: context);
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getSWData();
  // }

  // var data1;
  // var data2 = {
  //   "first_name": "",
  //   "last_name": "",
  //   "email": "",
  //   "password": "",
  //   "phone": "",
  //   "city": ""
  // };
  // Future<String> getSWData() async {
  //   var res = await http.get(
  //       Uri.parse("http://witpark.pythonanywhere.com/API/AllUser_API/"),
  //       headers: {"Accept": "application/json"});
  //   var resBody = json.decode(res.body);
  //   setState(() {
  //     data1 = resBody["data"];
  //   });
  //   for (var u in data1) {
  //     if (u["username"] == usernameLogin) {
  //       data2["first_name"] = u["first_name"];
  //       data2["last_name"] = u["last_name"];
  //       data2["email"] = u["email"];
  //       data2["password"] = u["password"];
  //       data2["phone"] = u["phone"];
  //       data2["city"] = u["city"];
  //     }
  //   }
  //   print(data2);
  //   return null;
  // }

  TextEditingController control = TextEditingController();
  var data = {
    "username": "usernameLogin",
    "oldpassword": "",
    "newpassword": ""
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/wit2.png"),
                maxRadius: 60,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Enter old password"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["oldpassword"] = value!;
                      },
                    ),
                    TextFormField(
                      controller: control,
                      decoration: const InputDecoration(
                          labelText: "Enter new password"),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return "Password is too short";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["newpassword"] = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Confirm new password"),
                      validator: (value) {
                        if (value != control.text || value!.isEmpty) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                    ),
                    spacer(context, 0.02),
                    ElevatedButton(
                      onPressed: () {
                        _submit();
                        showToast("Please wait..",
                            context: context, duration: Duration.zero);
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
