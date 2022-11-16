import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:witpark/MVVM/Views/Vehicles/edit_vehicle.dart';
import 'package:witpark/MVVM/Views/Authentication/login_page.dart';
import 'package:witpark/MVVM/Views/Vehicles/add_vehicles.dart';
import 'package:witpark/MVVM/Views/Vehicles/vehicles_cards.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Vehicles extends StatefulWidget {
  const Vehicles({super.key});

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  dynamic vLength;
  Future<List<VehiclesData>> _getUsers() async {
    var data = await http.get(
        Uri.parse("http://witpark.pythonanywhere.com/API/AllVehicles_API/"));
    var jsonData = json.decode(data.body);
    List<VehiclesData> users = [];

    for (var u in jsonData["data"]) {
      if (u["vehicle_owner"] == usernameLogin) {
        VehiclesData user = VehiclesData(
            u["vehicle_id"],
            u["vehicle_owner"],
            u["vehicle_name"],
            u["vehicle_model"].toString(),
            u["vehicle_color"],
            u["vehicle_no_plate"]);

        users.add(user);
      }
    }
    vLength = users;
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Vehicles',
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
        child: Column(children: [
          const Divider(
            color: Colors.black,
            thickness: 2,
            indent: 90,
            endIndent: 90,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: FutureBuilder(
              future: _getUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                } else if (snapshot.data.length == 0) {
                  return const Center(child: Text("No vehicles registered"));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  FlutterScaleRoute(
                                      page: EditVehicle(
                                          snapshot.data[index].vehicle_id)))
                              .then((_) {
                            _getUsers();
                            setState(() {});
                          });
                        },
                        child: VechiclesCards(
                            vname: snapshot.data[index].vehicle_name,
                            vmodel: snapshot.data[index].vehicle_model,
                            vnoplate: snapshot.data[index].vehicle_no_plate,
                            vcolor: snapshot.data[index].vehicle_color),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ]),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                    context, FlutterScaleRoute(page: AddVehicles(vLength)))
                .then((_) {
              setState(() {});
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class VehiclesData {
  final String vehicleId;
  final String vehicleOwner;
  final String vehicleName;
  final String vehicleModel;
  final String vehicleColor;
  final String vehicleNoPlate;
  VehiclesData(this.vehicleId, this.vehicleOwner, this.vehicleName,
      this.vehicleModel, this.vehicleColor, this.vehicleNoPlate);
}
