import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takip/components/skeleton/skelton.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.contain,
  });

  final String src;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: src,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        ),
        placeholder: (context, url) => const Skeleton(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
