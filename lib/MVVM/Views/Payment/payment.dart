import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:witpark/MVVM/Views/Profile/edit_profile.dart';

class Payment extends StatefulWidget {
  final dynamic payData;
  const Payment({super.key, this.payData});
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Payment',
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
        body: Column(children: [
          const Divider(
            color: Colors.black,
            thickness: 2,
            indent: 90,
            endIndent: 90,
          ),
          spacer(context, 0.15),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "Payment : \n\n  ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              spacer(context, 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Divider(
                  endIndent: MediaQuery.of(context).size.width * 0.7,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              spacer(context, 0.01),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "GST : \n\n  ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              spacer(context, 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Divider(
                  endIndent: MediaQuery.of(context).size.width * 0.8,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              spacer(context, 0.01),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "total : \n\n  ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              spacer(context, 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Divider(
                  endIndent: MediaQuery.of(context).size.width * 0.6,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Pay now"),
          )
        ]));
  }
}
