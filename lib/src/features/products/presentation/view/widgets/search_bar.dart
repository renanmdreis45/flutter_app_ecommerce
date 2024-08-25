import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {

  SearchBarWidget({Key? key, this.onChange}) : super(key: key);

  void Function(String value)? onChange;

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 15,
      left: 15,
      child: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              IconButton(
                splashColor: Colors.grey,
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  onChanged: widget.onChange,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Pesquisar produto"),
                ),
              ),
            ],
          )),
    );
  }
}
