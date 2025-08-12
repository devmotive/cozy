import 'package:cozy/generated/assets.dart';
import 'package:cozy/providers/recommended_space_provider.dart';
import 'package:cozy/theme/colors.dart';
import 'package:cozy/theme/typography.dart';
import 'package:cozy/widgets/city_card.dart';
import 'package:cozy/widgets/space_card.dart';
import 'package:cozy/widgets/tips_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  /// Route name for navigation.
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CityCard> _cities = [
    CityCard(imageUrl: Assets.assetsImageCity1, cityName: 'Jakarta'),
    CityCard(
      imageUrl: Assets.assetsImageCity2,
      cityName: 'Bandung',
      isPopular: true,
    ),
    CityCard(imageUrl: Assets.assetsImageCity3, cityName: 'Surabaya'),
    CityCard(imageUrl: Assets.assetsImageCity4, cityName: 'Palembang'),
    CityCard(imageUrl: Assets.assetsImageCity5, cityName: 'Aceh'),
    CityCard(imageUrl: Assets.assetsImageCity6, cityName: 'Bogor'),
  ];

  final List<TipsCard> _tips = [
    TipsCard(
      imageUrl: Assets.assetsIconTips1,
      title: 'City Guidelines',
      updatedAt: 'Updated 20 Apr',
    ),
    TipsCard(
      imageUrl: Assets.assetsIconTips2,
      title: 'Jakarta Fairship',
      updatedAt: 'Updated 11 Dec',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch recommended spaces when the widget is initialized.
    Future.microtask(() {
      if (!mounted) return;
      context.read<RecommendedSpaceProvider>().fetchRecommendedSpaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recommendedSpaceProvider = context.watch<RecommendedSpaceProvider>();

    // Display loading, error, or content based on the provider state.
    if (recommendedSpaceProvider.isLoading) {
      return _buildLoading();
    }

    if (recommendedSpaceProvider.hasError) {
      return _buildError(recommendedSpaceProvider);
    }

    return _buildContent(recommendedSpaceProvider);
  }

  /// Builds the loading indicator widget.
  Widget _buildLoading() {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  /// Builds the error message widget.
  Widget _buildError(RecommendedSpaceProvider provider) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 80),
            SizedBox(height: 24),
            Text(
              provider.errorMessage,
              style: TextStyle(
                color: kBlackColor,
                fontSize: 18,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => provider.retry(),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPurpleColor,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the main content of the home page.
  Widget _buildContent(RecommendedSpaceProvider provider) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildPopularCities(),
            _buildRecommendedSpaces(provider),
            _buildTips(),
          ],
        ),
      ),
    );
  }

  /// Builds the header section of the home page.
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(left: 24, bottom: 30),
      child: Column(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore Now',
            style: TextStyle(
              color: kBlackColor,
              fontSize: 24,
              fontWeight: medium,
            ),
          ),
          Text(
            'Mencari kosan yang cozy',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 16,
              fontWeight: light,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the popular cities section.
  Widget _buildPopularCities() {
    return Container(
      padding: EdgeInsets.only(left: 24, bottom: 30),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Cities',
            style: TextStyle(
              color: kBlackColor,
              fontSize: 16,
              fontWeight: regular,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _cities
                  .map(
                    (cityCard) => Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: cityCard,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the recommended spaces section.
  Widget _buildRecommendedSpaces(RecommendedSpaceProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended Space',
            style: TextStyle(
              color: kBlackColor,
              fontSize: 16,
              fontWeight: regular,
            ),
          ),
          SizedBox(height: 16),
          ...provider.recommendedSpaces.map(
            (space) => Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: SpaceCard(space: space),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the tips and guidance section.
  Widget _buildTips() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tips & Guidance',
            style: TextStyle(
              color: kBlackColor,
              fontSize: 16,
              fontWeight: regular,
            ),
          ),
          SizedBox(height: 16),
          ..._tips.map(
            (tip) => Padding(padding: EdgeInsets.only(bottom: 20), child: tip),
          ),
        ],
      ),
    );
  }
}
