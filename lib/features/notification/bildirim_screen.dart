import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/features/notification/bildiirim_notifier.dart';
import 'package:takip/features/notification/widgets/no_bildirim_view.dart';
import 'package:takip/features/notification/widgets/notification_tile.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/shop_home_page_scroll.dart';

class BildirimScreen extends ConsumerStatefulWidget {
  const BildirimScreen({super.key});

  @override
  ConsumerState<BildirimScreen> createState() => _BildirimScreenState();
}

class _BildirimScreenState extends ConsumerState<BildirimScreen> {
  @override
  void initState() {
    super.initState();

    // Notifier üzerinden veri çek
    Future.microtask(() {
      ref.read(bildirimNotifierProvider.notifier).hataliKayitlar();
    });
  }

  Future<void> refresh(String link) async {
    ref
        .read(urunKaydetNotifierProvider.notifier)
        .urunKaydet2(
          link,
          checkingText: LocalizationHelper.l10n.urunkontrol,
          gecerliGonderText: LocalizationHelper.l10n.gecerligonder,
          urunkaydediliyorText: LocalizationHelper.l10n.urunkaydediliyor,
          bittiText: LocalizationHelper.l10n.bitti,
          hataText: LocalizationHelper.l10n.hata,
        );
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => ShopHomePageScroll()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          LocalizationHelper.l10n.bildirimler,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, provider, child) {
            final state = ref.watch(bildirimNotifierProvider);
            final allItems = state.data;
            if (state.isLoading && allItems.length == 0) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (!state.isLoading && allItems.length == 0) {
              return const Center(child: NoBildirimView());
            }
            return Column(
              children: [
                // Bildirim listesi
                Expanded(
                  child: ListView.builder(
                    itemCount: allItems.length,
                    itemBuilder: (context, index) {
                      final urun = allItems[index];
                      return NotificationTile(
                        message: urun.link,
                        date: urun.getParsedDate(),
                        refresh: () => refresh(urun.link),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
