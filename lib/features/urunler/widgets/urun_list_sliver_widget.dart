import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/cards/blink_animation_component.dart';
import 'package:takip/components/snackbar/error_snackbar_component.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/features/markalar/marka_notifier.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urun_screen/product_detail_page.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/widgets/no_items_view_simple.dart';
import 'package:takip/features/urunler/widgets/responsive_error_product_card.dart';
import 'package:takip/features/urunler/widgets/responsive_urun_card_widget.dart';

class UrunListSliverWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<UrunListSliverWidget> createState() =>
      _UrunListSliverWidgetState();
}

class _UrunListSliverWidgetState extends ConsumerState<UrunListSliverWidget> {
  @override
  void initState() {
    super.initState();

    // Notifier üzerinden veri çek
    Future.microtask(() async {
      final localDataSource = sl<LocalDataSource>();
      final token = await localDataSource.getDeviceToken();
      if (token == null) {
        showErrorSnackBar(
          message: 'Bir hata oluştu. Uygulamayı yeniden başlatınız.',
        );
        return;
      }
      ref.read(urunNotifierProvider.notifier).initData();
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
  }

  Future<void> delete(String guidId) async {
    final result = await showConfirmDialog(
      title: LocalizationHelper.l10n.silmebaslik,
      content: LocalizationHelper.l10n.silmemetin,
    );

    if (result == true) {
      ref.read(urunNotifierProvider.notifier).urunSil(guidId);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(urunNotifierProvider);
    final stateMarka = ref.watch(markaNotifierProvider);
    final allItems = state.filteredData;

    if (state.isLoading && allItems.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    if (!state.isLoading && allItems.isEmpty) {
      return SliverToBoxAdapter(
        child: NoItemsViewSimple(selectedMarka: stateMarka.selectedMarka),
      );
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final urun = allItems[index];

        if (!urun.isHatali) {
          final productCard = ResponsiveUrunCardWidget(
            key: ValueKey(urun.iden),
            delete: () => delete(urun.iden),
            showDetail: () async {
              ref
                  .read(urunNotifierProvider.notifier)
                  .setSelectedProduct(urun.id);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductDetailPage()),
              );
            },
            urun: urun,
          );

          return urun.isSonBirSaat
              ? BlinkingCard(widget: productCard)
              : productCard;
        } else {
          return ResponsiveErrorProductCard(
            key: ValueKey(urun.iden),
            urun: urun,
            delete: () => delete(urun.iden),
          );
        }
      }, childCount: allItems.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
    );
  }
}
