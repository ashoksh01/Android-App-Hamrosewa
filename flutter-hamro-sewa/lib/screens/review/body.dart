import 'package:flutter/material.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/model/review.dart';
import 'package:najikkopasal/screens/review/reviewUI.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class Body extends StatefulWidget {
  List<Review>? reviews;
  double? ratings;
  Body({Key? key, this.reviews, this.ratings}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 219, 215, 215),
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.ratings!.toStringAsFixed(1),
                          style: TextStyle(fontSize: 48.0),
                        ),
                        const TextSpan(
                          text: "/5",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SmoothStarRating(
                    starCount: 5,
                    rating: widget.ratings!,
                    size: 28.0,
                    color: Colors.orange,
                    borderColor: Colors.orange,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    widget.reviews!.length.toString(),
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              Container(
                width: 200.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text(
                          "${index + 1}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(width: 4.0),
                        Icon(Icons.star, color: Colors.orange),
                        SizedBox(width: 8.0),
                        LinearPercentIndicator(
                          lineHeight: 6.0,
                          // linearStrokeCap: LinearStrokeCap.roundAll,
                          width: MediaQuery.of(context).size.width / 2.8,
                          animation: true,
                          animationDuration: 2500,
                          percent: ratings[index],
                          progressColor: Colors.orange,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10),
            itemCount: widget.reviews!.length,
            itemBuilder: ((context, index) {
              return ReviewUI(
                image: 'assets/images/profile.jpg',
                name: widget.reviews![index].name,
                date: widget.reviews?[index].time.toString().split("T")[0],
                rating: widget.reviews![index].rating!.toDouble(),
                comment: widget.reviews![index].comment,
                onTap: () {
                  setState(() {
                    isMore = !isMore;
                  });
                },
                isLess: isMore,
              );
            }),
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 3.0,
                color: Color.fromARGB(255, 239, 236, 236),
              );
            },
          ),
        ),
      ],
    );
  }
}
