import 'package:flutter/material.dart';

class ErrorSnakbar extends StatelessWidget {
  final String? message;
  const ErrorSnakbar({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 90,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Error",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(height: 7),
              Text(
                '$message',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ))
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 3, 14),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
