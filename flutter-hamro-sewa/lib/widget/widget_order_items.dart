import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:najikkopasal/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class WidgetOrderItems extends StatefulWidget {
  static String routeName = '/order_widget';
  final String? id;
  final String? totalPrice;
  final String? orderStatus;
  final Function()? onPressed;
  const WidgetOrderItems(
      {Key? key, this.id, this.totalPrice, this.onPressed, this.orderStatus})
      : super(key: key);

  @override
  State<WidgetOrderItems> createState() => _WidgetOrderItemsState();
}

class _WidgetOrderItemsState extends State<WidgetOrderItems> {
    void dialPhone() {
    // ignore: deprecated_member_use
    launch('tel://9840031602');
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        // give border

        child: Column(
          children: [
            const SizedBox(height: 10),
            // change iocn on basis of order status
            _orderStatus(widget.orderStatus.toString()),
            const Divider(
              height: 10,
              color: Colors.grey,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                    const Icon(Icons.edit,
                        color: Color.fromARGB(255, 18, 44, 189)),
                    const Text(
                      "Service Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Text(
                  widget.id.toString(),
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconText(
                    const Icon(Icons.price_check,
                        color: Color.fromARGB(255, 6, 9, 199)),
                    const Text(
                      "Service Price",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Text(
                  '₹${widget.totalPrice.toString()}',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadowColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        )),

                    // give color to button

                    onPressed: (){
                        dialPhone();
                    },
                    child: Row(
                      children: const [
                        Text(
                          "Call",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                       
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget iconText(Icon icon, Text text) {
    return Row(
      children: [
        icon,
        const SizedBox(
          height: 5,
        ),
        text
      ],
    );
  }

  Widget _orderStatus(String status) {
    Icon icon;
    Color color;
    switch (status) {
      case 'pending':
        icon = Icon(Icons.timer, color: Colors.orange);
        color = Colors.orange;
        break;
      case 'Completed':
        icon = Icon(Icons.check, color: Colors.green);
        color = Colors.green;
        break;
      case 'rejected':
        icon = Icon(Icons.close, color: Colors.red);
        color = Colors.red;
        break;
      case 'Delivered':
        icon = Icon(Icons.check, color: Colors.green);
        color = Colors.green;
        break;
      default:
        icon = Icon(Icons.timer, color: Colors.orange);
        color = Colors.orange;
    }
    return iconText(icon, Text(status, style: TextStyle(color: color)));
  }
}
