import 'package:flutter/material.dart';
import 'package:takip/components/image/network_image_with_loader.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatelessWidget {
  final UrunModel urun;
  final VoidCallback delete;
  final VoidCallback refresh;
  final VoidCallback bildirimAc;

  final String image;
  final String title;
  final double firstPrice;
  final String markaLogo;
  final double lastPrice;
  final String url;
  final bool isIslendi;
  const ProductCard({
    super.key,
    required this.urun,
    required this.image,
    required this.title,
    required this.firstPrice,
    required this.lastPrice,
    required this.url,
    required this.markaLogo,
    required this.delete,
    required this.isIslendi,
    required this.refresh,
    required this.bildirimAc,
  });

  Future<void> launchMyUrl(String url) async {
    try {
      final Uri uri = Uri.parse(Uri.encodeFull(url));

      final success = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!success) {}
    } catch (e) {}
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              !isIslendi
                  ? Positioned(
                      left: 5,
                      top: 5,
                      child: Badge(label: Text('Hatalı')),
                    )
                  : SizedBox.shrink(),
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  image,
                  height: 120,
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              isIslendi
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: bildirimAc,
                          child: CircleAvatar(
                            backgroundColor: Colors.white12,
                            child: urun.isBildirimAcik
                                ? Icon(
                                    Icons.notifications_active,
                                    color: Colors.teal,
                                  )
                                : Icon(Icons.notifications, color: Colors.grey),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$title',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          isIslendi
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "$lastPrice ₺",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      lastPrice != firstPrice
                          ? Text(
                              "$firstPrice ₺",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                )
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => launchMyUrl(url),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        isIslendi
                            ? CircleAvatar(
                                radius: 15,
                                child: NetworkImageWithLoader(markaLogo),
                              )
                            : GestureDetector(
                                onTap: refresh,
                                child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white12,
                                    child: Icon(
                                      Icons.refresh,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                              ),
                        CircleAvatar(
                          backgroundColor: Colors.white12,
                          radius: 15,
                          child: Icon(
                            Icons.shopping_cart_checkout,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final result = await showConfirmDialog(
                    title: 'Silme Onayı',
                    content: 'Bu ürünü silmek istediğinize emin misiniz?',
                  );

                  if (result == true) {
                    delete();
                  }
                },
                icon: Icon(Icons.remove_shopping_cart),
                color: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
