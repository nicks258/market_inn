import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget(
      {super.key, required this.imageUrl, this.height, this.width, this.fit});

  final String imageUrl;
  final double? height;
  final double? width;

  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != '') {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
        progressIndicatorBuilder: (context, child, loadingProgress) {
          return Center(
            child: CircularProgressIndicator.adaptive(
              value: loadingProgress.progress,
            ),
          );
        },
        errorWidget: (context, error, stackTrace) =>
            Image.asset("assets/images/stock_market.png",height: height,width: width,),
      );
    } else {
      return Image.asset("assets/images/stock_market.png",height: height,width: width,);
    }
  }
}
