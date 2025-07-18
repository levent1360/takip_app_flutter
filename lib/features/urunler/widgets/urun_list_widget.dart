import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/snackbar/success_snackbar_component.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urun_screen/product_detail_page.dart';
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
    ref.read(urunKaydetNotifierProvider.notifier).urunKaydet2(context, link);
  }

  Future<void> delete(String guidId) async {
    final result = await showConfirmDialog(
      title: LocalizationHelper.of(context).silmebaslik,
      content: LocalizationHelper.of(context).silmemetin,
    );

    if (result == true) {
      ref.read(urunNotifierProvider.notifier).urunSil(guidId);
    }
  }

  Future<void> bildirimAc(int id, bool deger) async {
    final result = await ref
        .read(urunNotifierProvider.notifier)
        .bildirimAc(id, deger);
    if (result == null) return;
    if (result) {
      showSuccessSnackBar(
        message: LocalizationHelper.of(context).bildirimkapatildi,
      );
    } else {
      showSuccessSnackBar(
        message: LocalizationHelper.of(context).bildirimacildi,
      );
    }
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

            if (!urun.isHatali) {
              return ProductCard(
                delete: () => delete(urun.iden),
                showDetail: () {
                  ref
                      .read(urunNotifierProvider.notifier)
                      .setSelectedProduct(urun.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProductDetailPage()),
                  );
                },
                bildirimAc: () => bildirimAc(urun.id, urun.isBildirimAcik),
                urun: urun,
              );
            } else {
              return ErrorProductCard(
                urun: urun,
                delete: () => delete(urun.iden),
                refresh: () => refresh(urun.link),
              );
            }
          },
        );
      },
    );
  }
}
