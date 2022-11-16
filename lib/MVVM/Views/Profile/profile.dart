import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:witpark/MVVM/Views/Profile/delete_user.dart';
import 'package:witpark/faq.dart';
import 'package:witpark/MVVM/Views/Bookings/booking_card.dart';
import 'package:witpark/MVVM/Views/Profile/edit_profile.dart';
import 'package:witpark/MVVM/Views/Vehicles/vehicles.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'edit_password.dart';
import '../Authentication/login_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late SharedPreferences pref;
  getpref() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getpref();
    getSWData1();
  }

  var isloading = true;
  dynamic data1;
  var data2 = {
    "id": "",
    "first_name": "",
    "last_name": "",
    "email": "",
    "phone": "",
    "city": ""
  };
  Future<String> getSWData1() async {
    var res = await http.get(
        Uri.parse("http://witpark.pythonanywhere.com/API/AllUser_API/"),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data1 = resBody["data"];
    });
    for (var u in data1) {
      if (u["username"] == usernameLogin) {
        data2["id"] = u["id"].toString();
        data2["first_name"] = u["first_name"];
        data2["last_name"] = u["last_name"];
        data2["email"] = u["email"];
        data2["phone"] = u["phone"];
        data2["city"] = u["city"];
      }
    }

    isloading = false;
    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.infinity,
        color: Colors.amber,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CircleAvatar(
                  radius: 62,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    maxRadius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(image),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        )),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isloading
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.115,
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Text("loading......")))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "${data2["first_name"]!} ${data2["last_name"]!}\n${data2["email"]!}\n${data2["phone"]!}\n${data2["city"]!}",
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                          spacer(context, 0.023),
                          const Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          spacer(context, 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          FlutterScaleRoute(
                                              page: EditProfile(data2["id"]!)))
                                      .then((_) {
                                    getSWData1();
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.amber,
                                      border: Border.all(
                                          width: 2, color: Colors.black)),
                                  child: const Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      FlutterScaleRoute(
                                          page: const Editpassword()));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.amber,
                                      border: Border.all(
                                          width: 2, color: Colors.black)),
                                  child: const Center(
                                    child: AutoSizeText(
                                      "Edit Password",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        )),
                    width: MediaQuery.of(context).size.width * 0.67,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const Center(
                        child: Text(
                      "Vehicles",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, FlutterScaleRoute(page: const Vehicles()));
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, FlutterScaleRoute(page: const FAQ()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        )),
                    width: MediaQuery.of(context).size.width * 0.67,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const Center(
                        child: Text(
                      "FAQ",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, FlutterScaleRoute(page: web(context)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        )),
                    width: MediaQuery.of(context).size.width * 0.67,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const Center(
                        child: Text(
                      "About",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        pref.clear();
                        // ignore: deprecated_member_use
                        pref.commit();

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginPage()),
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.black,
                            )),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: const Center(
                            child: Text(
                          "Logout",
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            FlutterScaleRoute(page: const DeleteUser()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.black,
                            )),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: const Center(
                            child: Text(
                          "Delete user",
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget web(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("About"),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios)),
    ),
    body: const WebView(
      initialUrl: 'http://witpark.pythonanywhere.com/WitPark/about/',
      javascriptMode: JavascriptMode.unrestricted,
    ),
  );
}
