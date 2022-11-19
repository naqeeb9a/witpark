import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Cities/city_model.dart';
import 'package:witpark/MVVM/ViewModels/Places/place_view_model.dart';
import 'package:witpark/Provider/selected_city_provider.dart';
import 'package:witpark/Widgets/custom_text.dart';

class ListDropDown extends StatefulWidget {
  final List<Datum>? givenList;
  const ListDropDown({Key? key, required this.givenList}) : super(key: key);

  @override
  State<ListDropDown> createState() => _ListDropDownState();
}

class _ListDropDownState extends State<ListDropDown> {
  @override
  Widget build(BuildContext context) {
    SelectedCityProvider selectedCityProvider =
        context.watch<SelectedCityProvider>();
    return DropdownButton(
      hint: Text(selectedCityProvider.selectedCity.split(",").removeAt(0)),
      underline: const CustomText(text: ""),
      items: widget.givenList!
          .map((value) => DropdownMenuItem(
                value: "${value.cityName},${value.id}",
                child: SizedBox(
                  width: 150.0, // for example
                  child: CustomText(
                    text: value.cityName.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
          .toList(),
      onChanged: (dynamic value) {
        context.read<PlaceModelView>().setModelError(null);
        context
            .read<PlaceModelView>()
            .getAllPlaces(value.toString().split(",").removeLast());
        setState(() {
          selectedCityProvider.setSelectedCity(value, check: true);
        });
      },
      // ...
    );
  }
}
