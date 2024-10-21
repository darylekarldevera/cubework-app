import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  late final String placeholderPath;
  final String imageAxis;
  final BoxFit fit;

  final String placeholderHorizontalPath =
      'lib/assets/images/placeholder_horizontal.jpg';
  final String placeholderVerticalPath =
      'lib/assets/images/placeholder_vertical.jpg';

  CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    String? imageAxis,
    this.fit = BoxFit.cover,
  }) : imageAxis = imageAxis ?? "horizontal" {
    placeholderPath = this.imageAxis == "horizontal"
        ? placeholderHorizontalPath
        : placeholderVerticalPath;
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Image.asset(
        placeholderPath,
        width: double.infinity,
        height: double.infinity, // Ensure placeholder takes full space
        fit: fit,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: double.infinity,
      height: double.infinity, // Ensure the image takes full space
      fit: fit,
    );
  }
}
