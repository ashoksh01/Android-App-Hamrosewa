// import 'package:flutter/material.dart';
// import 'package:najikkopasal/constants.dart';
// import 'package:najikkopasal/screens/home/components/bottom_manu.dart';
// import 'package:najikkopasal/screens/home/home_screen.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key}) : super(key: key);
//   static String routeName = '/home_screen';
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   PageController pageController = PageController();
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         itemCount: child.length,
//         controller: pageController,
//         onPageChanged: (value) => setState(() => selectedIndex = value),
//         itemBuilder: (itemBuilder, index) {
//           return Container(
//             child: child[index],
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//           elevation: 0,
//           child: SizedBox(
//             height: 60,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   for (int i = 0; bottomMenu.length > i; i++)
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           pageController.jumpToPage(i);
//                           selectedIndex = i;
//                         });
//                       },
//                       child: Image.asset(
//                         bottomMenu[i].imagePath,
//                         color: selectedIndex == i
//                             ? const Color.fromARGB(255, 9, 206, 28)
//                             : kPrimaryColor.withOpacity(0.5),
//                       ),
//                     )
//                 ]),
//           )),
//     );
//   }

//   List<Widget> child = [
//     HomePage(),
//     Container(
//       color: Colors.white,
//     ),
//     Container(
//       color: Colors.white,
//     ),
//     Container(
//       color: Colors.white,
//     ),
//   ];
// }
