import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/screens/ware/adminproduct.dart';
import 'package:najikkopasal/screens/ware/wareoshistroy.dart';
import 'package:wear/wear.dart';

class WareDashboard extends StatefulWidget {
  static String routeName = '/ware_os_dashbaord';

  const WareDashboard({Key? key}) : super(key: key);

  @override
  State<WareDashboard> createState() => _WareDashboardState();
}

class _WareDashboardState extends State<WareDashboard> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(
        builder: (context, mode, child) {
          return Scaffold(
              body: SafeArea(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GridView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, WareOshostory.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(20.0),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 67, 221, 154),
                                  Color.fromARGB(255, 14, 16, 123)
                                ],
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.history,
                                size: 40,
                                color: Color.fromARGB(255, 40, 212, 13),
                              ),
                              Text(
                                "Order History",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AllProduct.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(20.0),
                              gradient: new LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 67, 221, 154),
                                  Color.fromARGB(255, 14, 16, 123)
                                ],
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.production_quantity_limits,
                                size: 40,
                                color: Color.fromARGB(255, 1, 1, 1),
                              ),
                              Text(
                                "All Product",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )

                  // child: Column(

                  ));
        },
      );
    });
  }
}
