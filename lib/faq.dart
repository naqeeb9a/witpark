import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Future<void> mail() async {
    String username = 'info.witpark@gmail.com';
    String password = 'Naqeeb123';
    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, _authData["name"])
      ..recipients.add("info.witpark@gmail.com")
      ..subject = "Witpark FAQ app"
      ..text = "${_authData["name"]!}\n${_authData["message"]!}"
      ..html =
          "<h1> Name: ${_authData["name"]!}</h1><p> Message: ${_authData["message"]!}</p><p> Email: ${_authData["email"]!}</p><p> Phone number: ${_authData["phoneNo"]!}</p>";
    try {
      await send(message, smtpServer).then((value) {
        if (kDebugMode) {
          print('Message sent: $value');
        }
        showToast("Message sent", context: context);
        Navigator.pop(context);
      });
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Message not sent.');
      }
      showToast("Message not sent try again or check your email",
          context: context);
      for (var p in e.problems) {
        if (kDebugMode) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }
    var connection = PersistentConnection(smtpServer);
    await connection.close();
  }

  final _authData = {"name": "", "email": "", "phoneNo": "", "message": ""};

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    showToast("Please wait while your message is being sent",
        context: context, duration: Duration.zero);
    mail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'FAQ',
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
          child: Form(
            key: _formKey,
            child: Column(children: [
          const Divider(
            color: Colors.black,
            thickness: 2,
            indent: 120,
            endIndent: 120,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      labelText: "Name",
                      hintText: "Enter your Name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name must be provided";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData["name"] = value!;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      labelText: "Email",
                      hintText: "Enter your Email"),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      return "Invalid email";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData["email"] = value!;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      labelText: "Phone Number",
                      hintText: "Enter your Phone Number",
                      counterText: ""),
                  maxLength: 11,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 11) {
                      return "Number is wrong, enter an 11 digit number";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData["phoneNo"] = value!;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  maxLines: 8,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      labelText: "Message",
                      hintText: "Enter Message you want to send"),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 15) {
                      return "Message should be 15 characters long atleast";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData["message"] = value!;
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context);
              _submit();
            },
            child: const Text(
              "Send",
              style: TextStyle(color: Colors.black),
            ),
          )
            ]),
          ),
        ));
  }
}
