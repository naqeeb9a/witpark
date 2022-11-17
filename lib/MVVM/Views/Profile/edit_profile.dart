import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  final String pid;
  const EditProfile(this.pid, {super.key});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // ignore: non_constant_identifier_names

  updateUser() async {
    await http
        .put(
            Uri.parse(
                "https://witpark.pythonanywhere.com/API/Update_User_API/${widget.pid}"),
            body: data)
        .then((value) {
      if (value.statusCode == 200) {
        showToast("Successfully updated", context: context);
        Navigator.pop(context);
      } else {
        showToast("Not updated some error occured", context: context);
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    updateUser();
  }

  var data = {
    "first_name": "",
    "last_name": "",
    "email": "",
    "city": "",
    "phone": ""
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "firstname",
                          hintText: "Enter first name",
                          counterText: ""),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["first_name"] = value!;
                      },
                    ),
                    spacer(context, 0.01),
                    TextFormField(
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "last name",
                          hintText: "Enter last name",
                          counterText: ''),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["last_name"] = value!;
                      },
                    ),
                    spacer(context, 0.01),
                    TextFormField(
                      maxLength: 20,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: "email",
                          hintText: "Enter your email address",
                          counterText: ''),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return "check your email again";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["email"] = value!;
                      },
                    ),
                    spacer(context, 0.01),
                    TextFormField(
                      maxLength: 11,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "city",
                          hintText: "enter the city u live in",
                          counterText: ""),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["city"] = value!;
                      },
                    ),
                    spacer(context, 0.01),
                    TextFormField(
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "phone no",
                          hintText: "enter the phone number",
                          counterText: ""),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field cannot be empty";
                        } else if (value.length < 11) {
                          return "Phone number should have 11 digits check again";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["phone"] = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            ElevatedButton(
              onPressed: () {
                _submit();
              },
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget spacer(BuildContext context, double value) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * value,
  );
}
