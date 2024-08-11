import 'package:flutter/material.dart';

Widget buildLoginHeader(String imageSrc) {
  return Container(
    color: Colors.white,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Image(
        image: AssetImage(imageSrc),
      )),
    ),
  );
}
