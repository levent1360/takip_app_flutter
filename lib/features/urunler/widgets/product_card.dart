import 'package:flutter/material.dart';
import 'package:takip/components/image/network_image_with_loader.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/core/utils/format_money.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatelessWidget {
  final UrunModel urun;
  final VoidCallback delete;
  final VoidCallback bildirimAc;

  const ProductCard({
    super.key,
    required this.urun,
    required this.delete,
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
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: NetworkImageWithLoader(
                  urun.eImg!,
                  fit: BoxFit.contain,
                  width: 200,
                  height: 120,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: bildirimAc,
                    child: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: urun.isBildirimAcik
                          ? Icon(Icons.notifications_active, color: Colors.teal)
                          : Icon(Icons.notifications, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              urun.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  formatMoneyManual(urun.lastPrice!),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (urun.lastPrice != urun.firstPrice)
                        ? Colors.teal
                        : Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                urun.lastPrice != urun.firstPrice
                    ? Text(
                        formatMoneyManual(urun.firstPrice!),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => launchMyUrl(urun.link),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: NetworkImageWithLoader(urun.markaIcon!),
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
                icon: Icon(Icons.delete),
                color: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
