import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookingDetails extends StatefulWidget {
  String? bdowner;
  String? bdcity;
  String? bdplace;
  String? bdarrival;
  String? bddeparture;
  String? bdvehicle;
  String? bdamount;
  String? bdpaymentstatus;
  BookingDetails(
      {super.key,
      this.bdowner,
      this.bdcity,
      this.bdplace,
      this.bdarrival,
      this.bddeparture,
      this.bdvehicle,
      this.bdamount,
      this.bdpaymentstatus});
  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking details',
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
      body: Column(
        children: [
          const Divider(
            color: Colors.black,
            thickness: 2,
            indent: 90,
            endIndent: 90,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(15)),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const AutoSizeText(
                  "Parking Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: AutoSizeText(
                        "Name:  \n city: \n Parking: \n Arrival: \n Departure: \n No. plate: \n Amount: \n Credit: ",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    AutoSizeText(
                      " ${widget.bdowner}  \n ${widget.bdcity} \n ${widget.bdplace} \n ${widget.bdarrival} \n ${widget.bddeparture} \n ${widget.bdvehicle} \n ${widget.bdamount} \n ${widget.bdpaymentstatus} ",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const Icon(
                  Icons.directions,
                  size: 50,
                  color: Colors.black,
                ),
                const AutoSizeText('Get Directions')
              ],
            ),
          )
        ],
      ),
    );
  }
}
