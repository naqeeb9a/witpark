import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    double day3 = 60;
    double day10 = 50;
    double day20 = 40;
    double dayMore = 35;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.19,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    border: Border(
                        bottom: BorderSide(width: 2, color: Colors.black))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.042,
                    ),
                    const AutoSizeText(
                      "  WitPark",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                      maxLines: 1,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        "  An intelligent parking and online booking system.\n  for your needs",
                        style: GoogleFonts.aBeeZee(),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                "See our parking Gallery",
                style: GoogleFonts.aBeeZee(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    initialPage: 0, autoPlay: true, enlargeCenterPage: true),
                items: [
                  img(context, "assets/hero-1.jpg"),
                  img(context, "assets/hero-2.jpg"),
                  img(context, "assets/hero-3.jpg"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
                indent: 80,
                endIndent: 80,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                "Our key services",
                style: GoogleFonts.aBeeZee(),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Row(
                    children: [
                      card1(context, "online booking", Icons.calendar_today),
                      card1(context, "Advance booking", Icons.book),
                      card1(context, "Nearby availible parking", Icons.map),
                      card1(context, "E-payment", Icons.money),
                      card1(context, "24/7 Service", Icons.twenty_four_mp)
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
                indent: 80,
                endIndent: 80,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                "Prices we charge",
                style: GoogleFonts.aBeeZee(fontSize: 30),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber,
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView(
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text("Rs $day3 "),
                      subtitle: const Text("wholeday (3 days or less)"),
                      trailing:
                          const Icon(Icons.local_parking, color: Colors.white),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text("Rs $day10 "),
                      subtitle: const Text("wholeday (10 days)"),
                      trailing: const Icon(
                        Icons.local_parking,
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text("Rs $day20 "),
                      subtitle: const Text("wholeday (20 days)"),
                      trailing:
                          const Icon(Icons.local_parking, color: Colors.white),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text("Rs $dayMore "),
                      subtitle: const Text("wholeday (20+ days)"),
                      trailing:
                          const Icon(Icons.local_parking, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

img(BuildContext context, img) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.4,
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      semanticContainer: true,
      child: Image.asset(
        img,
        fit: BoxFit.cover,
      ),
    ),
  );
}

card1(BuildContext context, para1, icon1) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon1,
            color: Colors.amber,
            size: 80,
          ),
          AutoSizeText(para1,
              textAlign: TextAlign.center, style: GoogleFonts.aBeeZee()),
        ],
      ),
    ),
  );
}
