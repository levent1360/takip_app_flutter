import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/features/markalar/marka_notifier.dart';
import 'package:takip/features/markalar/widgets/marka_loading_widget.dart';
import 'package:takip/features/markalar/widgets/shop_category.dart';
import 'package:takip/features/urunler/urun_notifier.dart';

class MarkaScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<MarkaScreen> createState() => _MarkaScreenState();
}

class _MarkaScreenState extends ConsumerState<MarkaScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(markaNotifierProvider.notifier).getMarkas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, provider, child) {
        final state = ref.watch(markaNotifierProvider);
        final allItems = state.filteredData;
        final selectedItem = state.selectedMarka;

        if (!state.isLoading && allItems.length == 0) {
          return Center(
            child: Text(LocalizationHelper.l10n.herhangiveribulunamadi),
          );
        }

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.isLoading ? 5 : allItems.length,
            itemBuilder: (context, index) {
              if (state.isLoading) {
                return const MarkaLoadingWidget();
              } else {
                final marka = allItems[index];
                return MarkaWidget(
                  marka: marka,
                  isFiltered: selectedItem == null ? false : true,
                  isSelected: selectedItem?.name == marka.name,
                  onTap: (value) async {
                    await ref
                        .read(markaNotifierProvider.notifier)
                        .selectedMarka(marka);
                    ref
                        .read(urunNotifierProvider.notifier)
                        .filterData(ismarka: true);
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
