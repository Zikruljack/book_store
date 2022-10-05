import 'package:book_store/util/images.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  const CustomImage(
      {required this.image,
      required this.height,
      required this.width,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Image.asset(Images.placeholder,
          height: height, width: width, fit: fit),
      errorWidget: (context, url, error) => Image.asset(Images.placeholder,
          height: height, width: width, fit: fit),
    );
  }
}
