import 'package:flutter/material.dart';
import 'package:najikkopasal/model/review.dart';
import 'package:najikkopasal/screens/review/body.dart';

class ReviewUIScreen extends StatelessWidget {
  static String routeName = '/review';
  const ReviewUIScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewsData = ModalRoute.of(context)!.settings.arguments as Map;
    print(reviewsData.runtimeType);
    // converted _InternalLinkedHashMap<String, List<Review>?> to dynamic

    final review = reviewsData['reviews'] as List<Review>;
    final ratings = reviewsData['ratings'];
    print("Review ko UI ma aayo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(review.length);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Reviews',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 208, 39, 39)),
          ),
          centerTitle: true,
        ),
        body: Body(
          reviews: review,
          ratings: ratings,
        ));
  }
}
