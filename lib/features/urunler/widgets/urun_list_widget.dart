import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/widgets/product_card.dart';

class UrunListWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<UrunListWidget> createState() => _UrunListWidgetState();
}

class _UrunListWidgetState extends ConsumerState<UrunListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, provider, child) {
        final state = ref.watch(urunNotifierProvider);
        final allItems = state.data;

        if (state.isLoading && allItems.length == 0) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (!state.isLoading && allItems.length == 0) {
          return const Center(child: Text("Herhangi bir veri bulunamadı"));
        }

        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
          children: allItems.map((urun) {
            return ProductCard(
              image: urun.eImg, // varsayılan resim
              title: urun.name,
              price: urun.firstPrice,
              oldPrice: urun.lastPrice,
              url: urun.link, // örnek olarak eski fiyat
            );
          }).toList(),
        );
      },
    );
  }
}
