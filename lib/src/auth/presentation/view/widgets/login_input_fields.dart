import 'package:flutter/material.dart';

Widget buildLoginInputFields() {
  return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value != null || value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value != null || value!.isEmpty) {
                return 'Please enter somer text';
              }
              return null;
            },
          )
        ],
      )),
    ),
  );
}
