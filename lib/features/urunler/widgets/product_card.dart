import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final double oldPrice;
  final String url;
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.url,
  });

  void gotoUrl() async {
    final Uri _url = Uri.parse(this.url.toString());
    print('_url = $_url');

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, mode: LaunchMode.platformDefault);
    } else {
      print('URL açılamadı!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  image,
                  height: 130,
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const Positioned(
                right: 10,
                top: 10,
                child: Icon(Icons.favorite_border),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  "$price ₺",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                Text(
                  "$oldPrice ₺",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: gotoUrl,
              child: const Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
