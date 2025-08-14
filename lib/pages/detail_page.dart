import 'package:cozy/generated/assets.dart';
import 'package:cozy/models/space.dart';
import 'package:cozy/theme/colors.dart';
import 'package:cozy/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.space});

  static const routeName = '/detail';

  /// The [Space] object containing the details to be displayed.
  final Space space;

  Future<void> _launchPhoneUrl(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_buildHeaderImage(context), _buildDetailContent(context)],
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    // Container for the header image with back and favorite buttons.
    return Container(
      height: 350,
      width: double.infinity,
      padding: EdgeInsets.only(left: 24, top: 30, right: 24),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(space.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleIconButton(
            icon: Icons.chevron_left,
            // Navigates back to the previous screen.
            onPressed: () => Navigator.pop(context),
          ),
          _buildCircleIconButton(
            icon: Icons.favorite_border_outlined,
            // TODO: Implement favorite functionality.
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  /// Builds a circular icon button.
  Widget _buildCircleIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(color: kWhiteColor, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, color: kDarkPurpleColor),
        iconSize: 20,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context) {
    // Container for the main content of the detail page.
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 328),
      padding: EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleAndRating(),
            _buildMainFacilities(),
            _buildPhotos(),
            _buildLocation(),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndRating() {
    // Container for the title, price, and rating of the space.
    return Container(
      margin: EdgeInsets.only(top: 30, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  space.name,
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 22,
                    fontWeight: medium,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text.rich(
                  TextSpan(
                    text: '\$${space.price}',
                    style: TextStyle(
                      color: kPurpleColor,
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                    children: [
                      TextSpan(
                        text: ' / month',
                        style: TextStyle(
                          color: kDarkGreyColor,
                          fontSize: 16,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              final starNumber = index + 1;
              return Image.asset(
                Assets.assetsIconStar,
                width: 20,
                color: space.rating >= starNumber ? kOrangeColor : kGreyColor,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMainFacilities() {
    // Container for displaying the main facilities of the space.
    return Container(
      margin: EdgeInsets.only(right: 24),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Main Facilities',
            style: TextStyle(
              color: kBlackColor,
              fontSize: 16,
              fontWeight: regular,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFacilityItem(
                icon: Assets.assetsIconKitchen,
                value: space.numberOfKitchens,
                label: 'kitchen',
              ),
              _buildFacilityItem(
                icon: Assets.assetsIconBedroom,
                value: space.numberOfBedrooms,
                label: 'bedroom',
              ),
              _buildFacilityItem(
                icon: Assets.assetsIconKitchen,
                value: space.numberOfCupboards,
                label: 'cupboard',
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a facility item with an icon, value, and label.
  Widget _buildFacilityItem({
    required String icon,
    required int value,
    required String label,
  }) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(icon, width: 32),
        Text.rich(
          TextSpan(
            text: '$value',
            style: TextStyle(
              color: kPurpleColor,
              fontSize: 14,
              fontWeight: medium,
            ),
            children: [
              TextSpan(
                text: ' $label',
                style: TextStyle(
                  color: kDarkGreyColor,
                  fontSize: 14,
                  fontWeight: light,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotos() {
    // Column for displaying a horizontal list of photos of the space.
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photos',
          style: TextStyle(
            color: kBlackColor,
            fontSize: 16,
            fontWeight: regular,
          ),
        ),
        SizedBox(
          height: 88,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: space.photos.length,
            separatorBuilder: (context, index) => SizedBox(width: 18),
            // Builds each photo item.
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index == space.photos.length - 1 ? 24 : 0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    space.photos[index],
                    width: 110,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    // Container for displaying the location of the space and a map button.
    return Container(
      margin: EdgeInsets.only(right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              Text(
                '${space.address}\n${space.city}',
                style: TextStyle(
                  color: kDarkGreyColor,
                  fontSize: 14,
                  fontWeight: regular,
                ),
              ),
            ],
          ),
          _buildCircleMapButton(),
        ],
      ),
    );
  }

  /// Builds a circular button to show the location on a map.
  Widget _buildCircleMapButton() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(color: kLightGreyColor, shape: BoxShape.circle),
      child: IconButton(
        // TODO: Implement map functionality.
        onPressed: () {},
        iconSize: 22,
        color: kMediumGreyColor,
        icon: Icon(Icons.location_on),
      ),
    );
  }

  Widget _buildBookButton() {
    // Container for the "Book Now" button.
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(top: 10, right: 24, bottom: 40),
      child: ElevatedButton(
        onPressed: () => _launchPhoneUrl(space.phone),
        child: Text('Book Now'),
      ),
    );
  }
}
