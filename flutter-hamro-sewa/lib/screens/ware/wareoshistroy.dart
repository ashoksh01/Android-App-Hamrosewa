import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:najikkopasal/model/order.dart';
import 'package:najikkopasal/repository/productRepository.dart';
import 'package:najikkopasal/response/order_response.dart';
import 'package:najikkopasal/widget/ware_order-history_widget.dart';
import 'package:najikkopasal/widget/widget_order_items.dart';

class WareOshostory extends StatefulWidget {
  static String routeName = '/ware_oshistory';
  const WareOshostory({Key? key}) : super(key: key);
  @override
  State<WareOshostory> createState() => _WareOshostoryState();
}

class _WareOshostoryState extends State<WareOshostory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<OrderResponse?>(
            future: ProductRepository().getOrderHistory(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Order> lstOrder = snapshot.data!.orders!;
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: lstOrder.length,
                      itemBuilder: (context, index) {
                        return WareOSOrderGistoryWidget(
                          id: lstOrder[index].id,
                          totalPrice: lstOrder[index].totalPrice.toString(),
                          orderStatus: lstOrder[index].orderStatus,
                        );
                      },
                    ),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              return const Text("Error");
            }),
          ),
        ],
      ),
    );
  }
}
