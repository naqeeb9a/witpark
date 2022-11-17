import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:witpark/MVVM/Models/Bookings/all_bookings_model.dart';
import 'package:witpark/MVVM/Views/Bookings/bookings_details.dart';

class BookingCards extends StatefulWidget {
  final Datum booking;

  const BookingCards({super.key, required this.booking});

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
                        page: BookingDetails(booking: widget.booking)));
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
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            maxRadius: 30,
                            minRadius: 15,
                            backgroundImage: AssetImage("assets/wit2.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              "${widget.booking.bookingPlace} \nRs. ${widget.booking.bookingAmount}"),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 12, top: 3, bottom: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [status(widget.booking.bookingStatus)],
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
