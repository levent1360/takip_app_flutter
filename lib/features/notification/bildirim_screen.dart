import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/snackbar/success_snackbar_component.dart';
import 'package:takip/features/notification/bildiirim_notifier.dart';
import 'package:takip/features/notification/widgets/notification_tile.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/shop_home_page.dart';
import 'package:takip/features/urunler/widgets/no_items_view.dart';

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
    ref.read(urunKaydetNotifierProvider.notifier).getUrlProducts(link);
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => ShopHomePage()));
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
          'Bildirimler',
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
              return const Center(child: NoItemsView());
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
