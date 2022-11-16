import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class VechiclesCards extends StatefulWidget {
  final String vname;
  final String vmodel;
  final String vnoplate;
  final String vcolor;
  const VechiclesCards(
      {super.key,
      required this.vname,
      required this.vmodel,
      required this.vnoplate,
      required this.vcolor});
  @override
  State<VechiclesCards> createState() => _VechiclesCardsState();
}

class _VechiclesCardsState extends State<VechiclesCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    Timer(const Duration(milliseconds: 200),
        () => _animationController.forward());

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .animate(_animationController),
      child: FadeTransition(
        opacity: _animationController,
        child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12)),
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "${widget.vname} \n${widget.vmodel} model\n${widget.vcolor}",
                          style: const TextStyle(fontSize: 15),
                        ),
                        AutoSizeText(
                          widget.vnoplate,
                          style: const TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            )
          ]),
        ),
      ),
    );
  }
}
