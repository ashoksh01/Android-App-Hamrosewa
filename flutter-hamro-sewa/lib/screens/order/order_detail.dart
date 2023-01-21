import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:najikkopasal/model/orderItems.dart';

class OrderDetails extends StatefulWidget {
  static String routeName = '/order_details_page';
  const OrderDetails({Key? key}) : super(key: key);
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final order = args['OrderItems'];

    // use for loop to get all order items
    List<Widget> lstOrderItems = [];
    for (var i = 0; i < order.length; i++) {
      print(order[i].name);
    }

    // print orderlist
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Order Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            for (var i = 0; i < order.length; i++)
              Card(
                child: Container(
                  height: 100,
                  child: ListTile(
                    leading: Image.network(
                      order[i].image.toString(),
                      height: 60,
                    ),
                    title: Text(
                      order[i].name.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      order[i].price.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
          ],
        ));
  }
}
