import 'package:cozy/generated/assets.dart';
import 'package:cozy/theme/colors.dart';
import 'package:cozy/theme/typography.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  // The URL of the image to display for the city.
  final String imageUrl;

  // The name of the city.
  final String cityName;

  // A boolean indicating whether the city is popular.
  final bool isPopular;

  const CityCard({
    super.key,
    required this.imageUrl,
    required this.cityName,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: kLightGreyColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildCardImage(), _buildCityName()],
      ),
    );
  }

  // Builds the image section of the card.
  Widget _buildCardImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        children: [
          Image.asset(imageUrl, height: 102, width: 120, fit: BoxFit.cover),
          if (isPopular) _buildPopularBadge(),
        ],
      ),
    );
  }

  // Builds the "popular" badge if the city is marked as popular.
  Widget _buildPopularBadge() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 50,
        height: 30,
        padding: EdgeInsets.fromLTRB(17, 2, 11, 6),
        decoration: BoxDecoration(
          color: kPurpleColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36)),
        ),
        child: Image.asset(Assets.assetsIconStar, width: 22, height: 22),
      ),
    );
  }

  // Builds the text widget for the city name.
  Widget _buildCityName() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        cityName,
        style: TextStyle(fontSize: 16, fontWeight: medium),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
