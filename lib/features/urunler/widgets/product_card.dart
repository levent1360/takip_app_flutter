import 'package:flutter/material.dart';
import 'package:takip/components/image/network_image_with_loader.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:takip/features/urunler/widgets/full_image_page_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatefulWidget {
  final UrunModel urun;
  final VoidCallback delete;
  final VoidCallback bildirimAc;
  final VoidCallback showDetail;

  const ProductCard({
    Key? key,
    required this.urun,
    required this.delete,
    required this.bildirimAc,
    required this.showDetail,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 0.4; // %40 genişlik
    final imageHeight = imageWidth * 0.6; // oranlı yükseklik

    return GestureDetector(
      onTap: widget.showDetail,
      child: Container(
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              FullScreenImagePage(imageUrl: widget.urun.eImg!),
                        ),
                      );
                    },
                    child: NetworkImageWithLoader(
                      widget.urun.eImg!,
                      fit: BoxFit.contain,
                      width: imageWidth,
                      height: imageHeight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: widget.bildirimAc,
                      child: CircleAvatar(
                        backgroundColor: Colors.white12,
                        child: widget.urun.isBildirimAcik
                            ? Icon(
                                Icons.notifications_active,
                                color: Colors.teal,
                              )
                            : Icon(Icons.notifications, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                widget.urun.isTestData
                    ? Positioned(
                        left: 5,
                        top: 5,
                        child: Badge(
                          label: Text('Test', style: TextStyle(fontSize: 12)),
                          backgroundColor: Colors.red.shade400,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.urun.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          !widget.urun.isFiyatAyni
                              ? Text(
                                  widget.urun.firstPrice!.toString(),
                                  // formatMoneyManual(widget.urun.firstPrice!),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red,
                                  ),
                                )
                              : SizedBox(),
                          Text(
                            widget.urun.lastPrice!.toString(),
                            // formatMoneyManual(widget.urun.lastPrice!),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (widget.urun.isIndirim)
                                  ? Colors.teal
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                      if (widget.urun.isIndirim)
                        Icon(Icons.arrow_downward, color: Colors.teal),
                      if (widget.urun.isZamli)
                        Icon(Icons.arrow_upward, color: Colors.red),
                    ],
                  ),
                  widget.urun.priceList.length > 1
                      ? IconButton(
                          onPressed: widget.showDetail,
                          icon: Icon(Icons.history),
                          color: Colors.deepPurpleAccent,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => launchMyUrl(widget.urun.link),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: screenWidth * 0.04, // ekran oranına göre
                            child: NetworkImageWithLoader(
                              widget.urun.markaIcon!,
                            ),
                          ),
                          SizedBox(width: 4),
                          CircleAvatar(
                            backgroundColor: Colors.white12,
                            radius: screenWidth * 0.04,
                            child: Icon(
                              Icons.shopping_cart_checkout,
                              color: Colors.teal,
                              size: screenWidth * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: widget.delete,
                  icon: Icon(Icons.delete),
                  color: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
