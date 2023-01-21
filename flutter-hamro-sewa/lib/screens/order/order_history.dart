import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:najikkopasal/model/order.dart';
import 'package:najikkopasal/repository/productRepository.dart';
import 'package:najikkopasal/response/order_response.dart';
import 'package:najikkopasal/screens/order/order_detail.dart';
import 'package:najikkopasal/widget/widget_order_items.dart';

class OrderHistory extends StatefulWidget {
  static String routeName = '/order_history';
  const OrderHistory({Key? key}) : super(key: key);
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Order History",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: WidgetOrderItems(
                            id: "Elctrician - Assigned to Ashok Shrestha",
                            totalPrice: "1200",
                            orderStatus: "Pending",
                            onPressed: () {
                            
                            },
                          ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       FutureBuilder<OrderResponse?>(
      //         future: ProductRepository().getOrderHistory(),
      //         builder: ((context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.done) {
      //             if (snapshot.hasData) {
      //               List<Order> lstOrder = snapshot.data!.orders!;
      //               return Container(
      //                 child: ListView.builder(
      //                   shrinkWrap: true,
      //                   physics: ScrollPhysics(),
      //                   itemCount: lstOrder.length,
      //                   itemBuilder: (context, index) {
      //                     return WidgetOrderItems(
      //                       id: "Hello",
      //                       totalPrice: "1200",
      //                       orderStatus: "Pending",
      //                       onPressed: () {
      //                         Navigator.pushNamed(
      //                             context, OrderDetails.routeName, arguments: {
      //                           "OrderItems": lstOrder[index].orderItems
      //                         });
      //                       },
      //                     );
      //                   },
      //                 ),
      //               );
      //             }
      //           } else if (snapshot.connectionState ==
      //               ConnectionState.waiting) {
      //             return const Center(
      //               child: CupertinoActivityIndicator(
      //                 radius: 20,
      //               ),
      //             );
      //           }
      //           return const Text("Error");
      //         }),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
