import 'package:flutter/material.dart';

class Successbar extends StatelessWidget {
  final String? message;
  const Successbar({
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
          const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Success",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(height: 7),
              Text(
                "$message",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ))
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
