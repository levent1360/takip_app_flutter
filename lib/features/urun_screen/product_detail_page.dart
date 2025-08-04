import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/image/network_image_with_loader.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/features/markalar/marka_notifier.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/buttons/notification_status_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({super.key});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
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

  Future<void> delete(String guidId) async {
    final result = await showConfirmDialog(
      title: LocalizationHelper.l10n.silmebaslik,
      content: LocalizationHelper.l10n.silmemetin,
    );

    if (result == true) {
      // Sayfayı önce kapat
      Navigator.of(context).pop();

      // Ardından silme işlemini başlat
      Future.microtask(() {
        ref.read(urunNotifierProvider.notifier).urunSil(guidId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final urunState = ref.watch(urunNotifierProvider);
    final product = urunState.selectedProduct;

    if (product == null) return const CircularProgressIndicator();
    final markaName = ref
        .read(markaNotifierProvider.notifier)
        .getMarkaName(product.siteMarka!);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.4,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: NotificationStatusIcon(urunModel: product, size: 36),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                child: GestureDetector(
                  onTap: () => delete(product.iden),
                  child: CircleAvatar(
                    backgroundColor: Colors.white12,
                    child: Icon(
                      size: 36,
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(
                  child: NetworkImageWithLoader(
                    product.eImg!,
                    fit: BoxFit.contain,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          product.name!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            product.lastPrice!.toString(),
                            // formatMoneyManual(widget.urunModel.lastPrice!),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          Text(LocalizationHelper.l10n.guncelfiyat),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: screenWidth * 0.07,
                            child: NetworkImageWithLoader(product.markaIcon!),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            markaName.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 32, // yükseklik
                        child: OutlinedButton(
                          onPressed: () => launchMyUrl(product.link),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.teal,

                            side: const BorderSide(color: Colors.teal),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            LocalizationHelper.l10n.siteyegit,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text(
                    maxLines: 1,
                    product.link,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    LocalizationHelper.l10n.fiyatgecmisi,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    itemCount: product.priceList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final fiyat = product.priceList[index];
                      final fiyatTarih = product.priceDateList[index];
                      return Table(
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  fiyat,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  fiyatTarih,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              index == 0
                                  ? Chip(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      label: Text(
                                        LocalizationHelper.l10n.ilkfiyat,
                                      ),
                                      backgroundColor: Color(0xFFE8F5E9),
                                      labelStyle: TextStyle(color: Colors.teal),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ],
                      );
                      // return Padding(
                      //   padding: const EdgeInsets.only(bottom: 8),
                      //   child: Row(
                      //     mainAxisAlignment:
                      //         MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         fiyat,
                      //         // formatMoneyStringManual(fiyat),
                      //         style: const TextStyle(fontSize: 20),
                      //       ),
                      //       Text(
                      //         fiyatTarih ?? '',
                      //         // formatMoneyStringManual(fiyat),
                      //         style: const TextStyle(fontSize: 20),
                      //       ),
                      //       SizedBox(width: 20),
                      //       index == 0
                      //           ? Chip(
                      //               materialTapTargetSize:
                      //                   MaterialTapTargetSize.shrinkWrap,
                      //               label: Text('İlk Fiyat'),
                      //               backgroundColor: Color(0xFFE8F5E9),
                      //               labelStyle: TextStyle(
                      //                 color: Colors.teal,
                      //               ),
                      //             )
                      //           : SizedBox.shrink(),
                      //     ],
                      //   ),
                      // );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
