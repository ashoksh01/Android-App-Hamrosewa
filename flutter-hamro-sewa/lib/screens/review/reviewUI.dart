import 'package:flutter/material.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/size_config.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewUI extends StatelessWidget {
  final String? image;
  final String? name;
  final String? date;
  final String? comment;
  final double? rating;
  final Function()? onTap;
  final bool? isLess;
  const ReviewUI({
    Key? key,
    this.image,
    this.name,
    this.date,
    this.comment,
    this.rating,
    this.onTap,
    this.isLess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 17.0, right: .0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(right: 17),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
              Expanded(
                child: Text(
                  name!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            children: [
              SmoothStarRating(
                starCount: 5,
                rating: rating!,
                color: kPrimaryColor,
                borderColor: kPrimaryColor,
                halfFilledIconData: Icons.star_half,
              ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Text(
                date!,
                style: TextStyle(fontSize: 18, color: Colors.black),
              )
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          GestureDetector(
              onTap: onTap,
              child: isLess!
                  ? Text(comment!,
                      style: TextStyle(fontSize: 18, color: Colors.black))
                  : Text(comment!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: 18, color: Colors.black)))
        ],
      ),
    );
  }
}
