import 'package:flutter/material.dart';
import 'package:witpark/MVVM/Models/Places/place_model.dart';
import 'package:witpark/Widgets/custom_text.dart';

import '../Utils/utils.dart';

class PlaceListDropDown extends StatefulWidget {
  final List<Datum>? givenList;
  const PlaceListDropDown({Key? key, required this.givenList})
      : super(key: key);

  @override
  State<PlaceListDropDown> createState() => _PlaceListDropDownState();
}

class _PlaceListDropDownState extends State<PlaceListDropDown> {
  @override
  void initState() {
    selectedPlace = "${widget.givenList![0].placeName}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: CustomText(text: selectedPlace),
      underline: const CustomText(text: ""),
      items: widget.givenList!
          .map((value) => DropdownMenuItem(
                value: "${value.placeName}",
                child: SizedBox(
                  width: 150.0,
                  child: Text(
                    "${value.placeName}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
          .toList(),
      onChanged: (dynamic value) {
        setState(() {
          selectedPlace = value;
        });
      },
      // ...
    );
  }
}
