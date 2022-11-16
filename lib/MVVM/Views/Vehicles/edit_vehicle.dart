import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:http/http.dart' as http;
import 'package:witpark/MVVM/Views/Vehicles/vehicles.dart';
import '../Profile/edit_profile.dart';

class EditVehicle extends StatefulWidget {
  final String vid;
  const EditVehicle(this.vid, {super.key});
  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    updateVehicle();
  }

  updateVehicle() async {
    await http
        .put(
            Uri.parse(
                "https://witpark.pythonanywhere.com/API/Update_Vehicle_API/${widget.vid}"),
            body: data)
        .then((value) {
      if (value.statusCode == 404) {
        showToast("Vehicle not found", context: context);
      } else if (value.statusCode == 200) {
        showToast("vehicle updates successfully", context: context);
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
        Navigator.push(context, FlutterScaleRoute(page: const Vehicles()));
      } else {
        showToast("something went wrong", context: context);
      }
    });
  }

  var data = {
    "vehicle_name": "",
    "vehicle_model": "",
    "vehicle_color": "",
    "vehicle_no_plate": ""
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
        title: const AutoSizeText(
          "Edit vehicle",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              thickness: 2,
              color: Colors.black,
              indent: 140,
              endIndent: 140,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn3.iconfinder.com/data/icons/transport-02-set-of-vehicles-and-cars/110/Vehicles_and_cars_12-512.png"),
                maxRadius: 60,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "Vehicle name",
                          hintText: "Enter Vehicle name",
                          counterText: ""),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["vehicle_name"] = value!;
                      },
                    ),
                    spacer(context, 0.01),
                    TextFormField(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Vehicle Model",
                          hintText: "Enter Vehicle model",
                          counterText: ''),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["vehicle_model"] = value!;
                      },
                    ),
                    spacer(context, 0.01),
                    TextFormField(
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "Vehicle Color",
                          hintText: "Enter vehicle color",
                          counterText: ''),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["vehicle_color"] = value!;
                      },
                    ),
                    spacer(context, 0.01),
                    TextFormField(
                      maxLength: 11,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "vehicle no plate",
                          hintText: "enter vehicle's number plate",
                          counterText: ""),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data["vehicle_no_plate"] = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                _submit();
                showToast("Please wait...",
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
    );
  }
}
