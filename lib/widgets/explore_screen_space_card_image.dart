import 'package:carousel_slider/carousel_slider.dart';
import 'package:cubework_app_client/shared/components/custom_cache_network_image.dart';
import 'package:flutter/material.dart';

class ExploreScreenSpaceCardImage extends StatefulWidget {
  final List<String> images;
  const ExploreScreenSpaceCardImage({super.key, required this.images});

  @override
  State<ExploreScreenSpaceCardImage> createState() =>
      _ExploreScreenSpaceCardImageState();
}

class _ExploreScreenSpaceCardImageState
    extends State<ExploreScreenSpaceCardImage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height:
                    MediaQuery.of(context).size.height * 0.30, // Control height
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                scrollDirection: Axis.horizontal,
                // Disable this to prevent shrinking
                enlargeCenterPage: false,
                // Make sure each item takes full width
                viewportFraction: 1.0,
                onPageChanged: (index, _) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
              items: widget.images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CustomCachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const Positioned(
              right: 15,
              top: 10,
              child: Icon(Icons.favorite_border, color: Colors.white),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: index == currentPage
                        ? 10
                        : 6, // Dot sizes for active/inactive
                    height: index == currentPage ? 10 : 6,
                    decoration: BoxDecoration(
                      color: index == currentPage
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
