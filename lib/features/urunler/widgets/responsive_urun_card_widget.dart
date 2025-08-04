import 'package:flutter/material.dart';
import 'package:takip/components/image/network_image_with_loader.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:takip/features/urunler/widgets/full_image_page_screen.dart';
import 'package:takip/features/urunler/buttons/urun_card_notification_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ResponsiveUrunCardWidget extends StatelessWidget {
  final UrunModel urun;
  final VoidCallback showDetail;
  final VoidCallback delete;

  const ResponsiveUrunCardWidget({
    required this.urun,
    required this.showDetail,
    required this.delete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final fontSizeSmall = isTablet ? 16.0 : 12.0;
    final fontSizeNormal = isTablet ? 18.0 : 14.0;
    final iconSize = isTablet ? 32.0 : 24.0;
    final containerPadding = isTablet ? 16.0 : 8.0;

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

    return GestureDetector(
      onTap: showDetail,
      child: Container(
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AspectRatio(
              aspectRatio: isTablet ? 16 / 7 : 15 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FullScreenImagePage(imageUrl: urun.eImg!),
                            ),
                          );
                        },
                        child: NetworkImageWithLoader(
                          urun.eImg!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    if (urun.isTestData)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Test',
                            style: TextStyle(
                              fontSize: fontSizeSmall,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    UrunCardNotificationWidget(urun: urun, iconSize: iconSize),
                  ],
                ),
              ),
            ),
            SizedBox(height: containerPadding / 2),
            Text(
              urun.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeSmall,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!urun.isFiyatAyni)
                      Text(
                        urun.firstPrice.toString(),
                        style: TextStyle(
                          fontSize: fontSizeSmall,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                        ),
                      ),
                    Text(
                      urun.lastPrice.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: urun.isIndirim ? Colors.teal : Colors.black,
                        fontSize: fontSizeNormal,
                      ),
                    ),
                  ],
                ),
                if (urun.priceList.length > 1)
                  IconButton(
                    onPressed: showDetail,
                    icon: Icon(Icons.history),
                    color: Colors.deepPurpleAccent,
                    iconSize: iconSize,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => launchMyUrl(urun.link),
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.lightBlueAccent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.blueGrey[100],
                      radius: screenWidth * 0.04,
                      child: NetworkImageWithLoader(urun.markaIcon!),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: delete,
                  icon: Icon(Icons.delete),
                  color: Colors.redAccent,
                  iconSize: iconSize,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
