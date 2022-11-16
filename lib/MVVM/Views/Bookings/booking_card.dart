import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:witpark/MVVM/Views/Bookings/bookings_details.dart';

var image = "assets/wit2.png";

// ignore: must_be_immutable
class BookingCards extends StatefulWidget {
  String bowner;
  String bcity;
  String bplace;
  String barrival;
  String bdeparture;
  String bvehicle;
  String bamount;
  String bstatus;
  String bpaymentstatus;
  BookingCards(
      {super.key, required this.bowner,
      required this.bcity,
      required this.bplace,
      required this.barrival,
      required this.bdeparture,
      required this.bvehicle,
      required this.bamount,
      required this.bstatus,
      required this.bpaymentstatus});

  @override
  State<BookingCards> createState() => _BookingCardsState();
}

class _BookingCardsState extends State<BookingCards> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    FlutterScaleRoute(
                        page: BookingDetails(
                      bdowner: widget.bowner,
                      bdcity: widget.bcity,
                      bdplace: widget.bplace,
                      bdarrival: widget.barrival,
                      bddeparture: widget.bdeparture,
                      bdvehicle: widget.bvehicle,
                      bdamount: widget.bamount,
                      bdpaymentstatus: widget.bpaymentstatus,
                    )));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            maxRadius: 30,
                            minRadius: 15,
                            backgroundImage: AssetImage(image),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:
                              Text("${widget.bplace} \nRs. ${widget.bamount}"),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 12, top: 3, bottom: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [status(widget.bstatus)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      )
    ]);
  }
}

Widget status(a) {
  if (a == "active") {
    return Text(
      a,
      style: const TextStyle(color: Colors.green),
    );
  }
  if (a == "clear") {
    return Text(
      a,
      style: const TextStyle(color: Colors.red),
    );
  }
  return Container();
}
