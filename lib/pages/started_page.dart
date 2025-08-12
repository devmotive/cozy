import 'package:cozy/generated/assets.dart';
import 'package:cozy/theme/colors.dart';
import 'package:cozy/theme/typography.dart';
import 'package:flutter/material.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  // routeName is used for navigation, allowing easy access to this page.
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildContent(), SizedBox(height: 24), _buildSplashImage()],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogo(),
          _buildTitle(),
          SizedBox(height: 10),
          _buildSubtitle(),
          SizedBox(height: 40),
          _buildExploreButton(),
        ],
      ),
    );
  }

  // _buildLogo displays the application's logo.
  Widget _buildLogo() {
    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.only(top: 50, bottom: 30),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(Assets.assetsLogo)),
      ),
    );
  }

  // _buildTitle displays the main heading of the page.
  Widget _buildTitle() {
    return Text(
      'Find Cozy House\n'
      'to Stay and Happy',
      style: TextStyle(color: kBlackColor, fontSize: 24, fontWeight: medium),
    );
  }

  // _buildSubtitle displays a supporting tagline or description.
  Widget _buildSubtitle() {
    return Text(
      'Stop membuang banyak waktu\n'
      'pada tempat yang tidak habitable',
      style: TextStyle(color: kGreyColor, fontSize: 16, fontWeight: light),
    );
  }

  // _buildExploreButton provides a call-to-action for users to proceed.
  Widget _buildExploreButton() {
    return SizedBox(
      width: 210,
      height: 50,
      child: ElevatedButton(
        // TODO: Implement navigation to the next screen (e.g., HomePage).
        onPressed: () {},
        child: Text('Explore Now'),
      ),
    );
  }

  // _buildSplashImage displays a visually appealing image at the bottom of the page.
  Widget _buildSplashImage() {
    return Image.asset(
      Assets.assetsSplashImage,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
