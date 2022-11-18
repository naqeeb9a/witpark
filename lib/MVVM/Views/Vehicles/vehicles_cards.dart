import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/MVVM/Views/Vehicles/edit_vehicle.dart';
import 'package:witpark/Utils/app_routes.dart';

class VechiclesCards extends StatefulWidget {
  final Datum vehicle;
  const VechiclesCards({super.key, required this.vehicle});
  @override
  State<VechiclesCards> createState() => _VechiclesCardsState();
}

class _VechiclesCardsState extends State<VechiclesCards> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        KRoutes.push(context, EditVehicle(widget.vehicle));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              "${widget.vehicle.vehicleName} \n${widget.vehicle.vehicleModel} model\n${widget.vehicle.vehicleColor}",
              style: const TextStyle(fontSize: 15),
            ),
            AutoSizeText(
              widget.vehicle.vehicleNoPlate ?? "",
              style: const TextStyle(
                  color: Colors.amber, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
