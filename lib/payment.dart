import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:witpark/MVVM/Views/Authentication/login_page.dart';
import 'package:witpark/MVVM/Views/Profile/edit_profile.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  final dynamic payData;
  const Payment({super.key, this.payData});
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  dynamic showPayment;
  dynamic gst;
  dynamic total;
  @override
  void initState() {
    super.initState();
    _getPayment();
  }

  postData() async {
    widget.payData["booking_owner"] = "$usernameLogin";
    widget.payData["booking_payment_date"] =
        DateTime.now().toString().substring(0, 10);

    await http
        .post(
            Uri.parse("http://witpark.pythonanywhere.com/API/Add_Booking_API/"),
            body: widget.payData)
        .then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        showToast("successfully added", context: context);
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
      } else {
        showToast("Error", context: context);
      }
    });
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  _getPayment() {
    var a = widget.payData["booking_arrival"];
    var b = widget.payData["booking_departure"];
    var date = int.parse(a.toString().substring(8, 10));
    var month = int.parse(a.toString().substring(5, 7));
    var year = int.parse(b.toString().substring(0, 4));
    var month1 = int.parse(b.toString().substring(5, 7));
    var date1 = int.parse(b.toString().substring(8, 10));
    var year1 = int.parse(b.toString().substring(0, 4));
    var differenceDate = date - date1;
    var differenceMonth = month - month1;
    var differenceYear = year - year1;

    if (differenceDate.isNegative) {
      differenceDate = -1 * differenceDate;
    }
    if (differenceMonth.isNegative) {
      differenceMonth = -1 * differenceMonth;
    }

    if (kDebugMode) {
      print(differenceYear);
    }
    if (differenceMonth > 0) {
      if (month == 1) {
        date = date - 31;
        date = date * -1;
        date = date + date1;
      } else if (month == 2) {
        date = date - 28;
        date = date * -1;
        date = date + date1;
      } else if (month == 3) {
        date = date - 31;
        date = date * -1;
        date = date + date1;
      } else if (month == 4) {
        date = date - 30;
        date = date * -1;
        date = date + date1;
      } else if (month == 5) {
        date = date - 31;
        date = date * -1;
        date = date + date1;
      } else if (month == 6) {
        date = date - 30;
        date = date * -1;
        date = date + date1;
      } else if (month == 7) {
        date = date - 31;
        date = date * -1;
        date = date + date1;
      } else if (month == 8) {
        date = date - 31;
        date = date * -1;
        date = date + date1;
      } else if (month == 9) {
        date = date - 30;
        date = date * -1;
        date = date + date1;
      } else if (month == 10) {
        date = date - 31;
        date = date * -1;
        date = date + date1;
      } else if (month == 11) {
        date = date - 30;
        date = date * -1;
        date = date + date1;
      } else if (month == 12) {
        date = date - 31;
        date = date * -1;
        date = date + date1;
      }
    }

    if (differenceDate == 0 && differenceMonth == 0) {
      showPayment = 60;
    } else if (differenceDate > 0 &&
        differenceDate <= 3 &&
        differenceMonth == 0) {
      showPayment = 60 * differenceDate;
    } else if (differenceDate > 3 &&
        differenceDate <= 9 &&
        differenceMonth == 0) {
      showPayment = 50 * differenceDate;
    } else if (differenceDate > 9 &&
        differenceDate <= 20 &&
        differenceMonth == 0) {
      showPayment = 40 * differenceDate;
    } else if (differenceDate > 20 && differenceMonth == 0) {
      showPayment = 35 * differenceDate;
    } else if (date > 0 && date <= 3 && differenceMonth > 0) {
      showPayment = 60 * date;
    } else if (date > 3 && date <= 9 && differenceMonth > 0) {
      showPayment = 50 * date;
    } else if (date > 9 && date <= 20 && differenceMonth > 0) {
      showPayment = 40 * date;
    } else if (date > 20 && differenceMonth > 0) {
      showPayment = 35 * date;
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
    gst = showPayment * (5 / 100);
    total = gst + showPayment;
    widget.payData["booking_amount"] = total.toString();
  }

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
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "Payment : \n\n $showPayment ",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "GST : \n\n $gst ",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "total : \n\n $total ",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
            onPressed: () {
              postData();
            },
            child: const Text("Pay now"),
          )
        ]));
  }
}
