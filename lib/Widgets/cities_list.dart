import 'package:flutter/material.dart';
import 'package:witpark/MVVM/Models/Cities/city_model.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_text.dart';

class ListDropDown extends StatefulWidget {
  final List<Datum>? givenList;
  const ListDropDown({Key? key, required this.givenList}) : super(key: key);

  @override
  State<ListDropDown> createState() => _ListDropDownState();
}

class _ListDropDownState extends State<ListDropDown> {
  @override
  void initState() {
    selectedCity = widget.givenList![0].cityName.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCity,
      underline: const CustomText(text: ""),
      items: widget.givenList!
          .map((value) => DropdownMenuItem(
                value: value.cityName.toString(),
                child: SizedBox(
                  width: 100.0, // for example
                  child: CustomText(
                    text: value.cityName.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
          .toList(),
      onChanged: (dynamic value) {
        setState(() {
          selectedCity = value;
        });
      },
      // ...
    );
  }
}
