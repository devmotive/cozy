import 'package:cozy/theme/colors.dart';
import 'package:cozy/theme/typography.dart';
import 'package:flutter/cupertino.dart';

class TipsCard extends StatelessWidget {
  // The URL of the image to display in the card.
  final String imageUrl;

  // The title of the tip.
  final String title;

  // The date when the tip was last updated.
  final String updatedAt;

  const TipsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildImage(),
        SizedBox(width: 16),
        _buildTextInfo(),
        Spacer(),
        _buildChevronIcon(),
      ],
    );
  }

  // Builds the image part of the card.
  Widget _buildImage() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }

  // Builds the text information part of the card (title and updated date).
  Widget _buildTextInfo() {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: kBlackColor,
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        Text(
          updatedAt,
          style: TextStyle(
            color: kDarkGreyColor,
            fontSize: 14,
            fontWeight: light,
          ),
        ),
      ],
    );
  }

  // Builds the chevron icon on the right side of the card.
  Widget _buildChevronIcon() {
    return Icon(CupertinoIcons.right_chevron, color: kSilverColor, size: 24);
  }
}
