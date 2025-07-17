import 'package:flutter/material.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorProductCard extends StatelessWidget {
  final UrunModel urun;
  final VoidCallback delete;
  final VoidCallback refresh;

  const ErrorProductCard({
    super.key,
    required this.urun,
    required this.delete,
    required this.refresh,
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
              Positioned(left: 5, top: 5, child: Badge(label: Text('Hatalı'))),
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  urun.eImg!,
                  height: 120,
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  fit: BoxFit.contain,
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
                        GestureDetector(
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
