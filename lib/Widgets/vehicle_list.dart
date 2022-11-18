import 'package:flutter/material.dart';
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_text.dart';

class VehicleListDropDown extends StatefulWidget {
  final List<Datum>? givenList;
  const VehicleListDropDown({Key? key, required this.givenList})
      : super(key: key);

  @override
  State<VehicleListDropDown> createState() => _VehicleListDropDownState();
}

class _VehicleListDropDownState extends State<VehicleListDropDown> {
  @override
  void initState() {
    selectedVehicle =
        "${widget.givenList![0].vehicleName} ${widget.givenList![0].vehicleNoPlate}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedVehicle,
      underline: const CustomText(text: ""),
      items: widget.givenList!
          .map((value) => DropdownMenuItem(
                value: "${value.vehicleName} ${value.vehicleNoPlate}",
                child: SizedBox(
                  width: 100.0,
                  child: CustomText(
                    text: "${value.vehicleName} ${value.vehicleNoPlate}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
          .toList(),
      onChanged: (dynamic value) {
        setState(() {
          selectedVehicle = value;
        });
      },
      // ...
    );
  }
}
