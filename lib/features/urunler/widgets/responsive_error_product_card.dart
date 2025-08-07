import 'package:flutter/material.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/features/urunler/urun_model.dart';

class ResponsiveErrorProductCard extends StatelessWidget {
  final UrunModel urun;
  final VoidCallback delete;

  const ResponsiveErrorProductCard({
    super.key,
    required this.urun,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final fontSizeSmall = isTablet ? 16.0 : 12.0;
    final iconSize = isTablet ? 32.0 : 24.0;
    final containerPadding = isTablet ? 16.0 : 8.0;

    Future<void> showInformation() async {
      await showConfirmDialog(
        title: LocalizationHelper.l10n.hatalikayitislemi,
        content: LocalizationHelper.l10n.uruneklenemedibilgi,
        confirmText: LocalizationHelper.l10n.tamam,
        confirmColor: Colors.teal,
        isShowCancel: false,
      );
    }

    return GestureDetector(
      onTap: showInformation,
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
                    Positioned(
                      left: 5,
                      top: 5,
                      child: Badge(label: Text(LocalizationHelper.l10n.hata)),
                    ),
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/no_item.png',
                        height: 120,
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: containerPadding / 2),
            Text(
              urun.link,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeSmall,
              ),
            ),
            SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
