import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/widgets/error_product_card.dart';
import 'package:takip/features/urunler/widgets/no_items_view.dart';
import 'package:takip/features/urunler/widgets/product_card.dart';

class UrunListWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<UrunListWidget> createState() => _UrunListWidgetState();
}

class _UrunListWidgetState extends ConsumerState<UrunListWidget> {
  @override
  void initState() {
    super.initState();

    // Notifier üzerinden veri çek
    Future.microtask(() {
      ref.read(urunNotifierProvider.notifier).getProducts();
    });
  }

  Future<void> refresh(String link) async {
    ref.read(urunKaydetNotifierProvider.notifier).urunKaydet2(link);
  }

  Future<void> delete(int id) async {
    ref.read(urunNotifierProvider.notifier).urunSil(id);
  }

  Future<void> bildirimAc(int id, bool deger) async {
    ref.read(urunNotifierProvider.notifier).bildirimAc(id, deger);
  }

  Future<void> hataliSil(String url) async {
    ref.read(urunNotifierProvider.notifier).hataliSil(url);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, provider, child) {
        final state = ref.watch(urunNotifierProvider);
        final allItems = state.filteredData;

        if (state.isLoading && allItems.length == 0) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (!state.isLoading && allItems.length == 0) {
          return const Center(child: NoItemsView());
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // satırda kaç kutu olacak
            childAspectRatio: 0.7, // genişlik / yükseklik oranı
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          padding: const EdgeInsets.all(5),
          itemCount: allItems.length,
          itemBuilder: (context, index) {
            final urun = allItems[index];

            if (urun.isIslendi) {
              return ProductCard(
                delete: () => delete(urun.id),
                bildirimAc: () => bildirimAc(urun.id, urun.isBildirimAcik),
                urun: urun,
              );
            } else {
              return ErrorProductCard(
                urun: urun,
                delete: () => hataliSil(urun.link),
                refresh: () => refresh(urun.link),
              );
            }
          },
        );
      },
    );
  }
}
