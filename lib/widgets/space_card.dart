import 'package:cozy/generated/assets.dart';
import 'package:cozy/models/space.dart';
import 'package:cozy/theme/colors.dart';
import 'package:cozy/theme/typography.dart';
import 'package:flutter/material.dart';

class SpaceCard extends StatelessWidget {
  const SpaceCard({super.key, required this.space});

  /// The space to display.
  final Space space;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement navigation to space details page on tap.
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: space),
      child: Row(
        spacing: 20,
        children: [_buildImageWithRating(), _buildSpaceDetails()],
      ),
    );
  }

  /// Builds the image section of the card, including the rating badge.
  Widget _buildImageWithRating() {
    // TODO: Add placeholder image for when space.imageUrl is invalid or loading.
    // TODO: Add error handling for NetworkImage.
    // Container for the image and rating badge.
    return Hero(
      tag: space.imageUrl,
      child: Container(
        height: 110,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            image: NetworkImage(space.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.topRight,
        // Display the rating badge on top of the image.
        child: _buildRatingBadge(),
      ),
    );
  }

  Widget _buildRatingBadge() {
    // Container for the rating badge.
    return Container(
      height: 30,
      width: 70,
      decoration: BoxDecoration(
        color: kPurpleColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(36),
        ),
      ),
      child: Row(
        spacing: 2,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.assetsIconStar, width: 18, height: 18),
          Text(
            '${space.rating}/5',
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 13,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the details section of the card, including name, price, and location.
  Widget _buildSpaceDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            space.name,
            style: TextStyle(
              color: kBlackColor,
              fontSize: 18,
              fontWeight: medium,
            ),
            overflow: TextOverflow.ellipsis,
            // Handle long names by showing ellipsis.
          ),
          SizedBox(height: 2),
          RichText(
            // Use RichText to style different parts of the price string.
            text: TextSpan(
              style: TextStyle(fontSize: 16),
              children: [
                TextSpan(
                  text: '\$${space.price}',
                  style: TextStyle(color: kPurpleColor, fontWeight: medium),
                ),
                TextSpan(
                  text: ' / month',
                  style: TextStyle(color: kDarkGreyColor, fontWeight: light),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            '${space.city}, ${space.country}',
            style: TextStyle(
              color: kDarkGreyColor,
              fontSize: 14,
              fontWeight: light,
            ),
          ),
        ],
      ),
    );
  }
}
