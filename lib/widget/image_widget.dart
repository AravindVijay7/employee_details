import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_details/constants/string_constants.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final imageUrl;
  final double height;
  final double width;

  const ImageWidget({Key? key,required this.imageUrl,required this.height,required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widget;
    return CachedNetworkImage(
      imageUrl: '${imageUrl??noImage}',
      height: height,
      width: widget,
      // fit: BoxFit.contain,

      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(150))),
      ),

      placeholder: (ctx, url) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: CircularProgressIndicator(
          strokeWidth: 4,
        ),
      ),
    );
  }
}
