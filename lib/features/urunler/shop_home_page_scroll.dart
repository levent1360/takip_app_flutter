import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/features/markalar/marka_notifier.dart';
import 'package:takip/features/markalar/marka_screen.dart';
import 'package:takip/features/searchbar/search_bar_screen.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/widgets/animation_please_wait_container_widget.dart';
import 'package:takip/features/urunler/widgets/urun_list_sliver_widget.dart';

class ShopHomePageScroll extends ConsumerStatefulWidget {
  const ShopHomePageScroll({super.key});

  @override
  ConsumerState<ShopHomePageScroll> createState() => _ShopHomePageScrollState();
}

class _ShopHomePageScrollState extends ConsumerState<ShopHomePageScroll> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final urunState = ref.read(urunNotifierProvider);
    if (!urunState.isNextLoading &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
      ref.read(urunNotifierProvider.notifier).initData(isNext: true);
    }
  }

  Future<void> refresh() async {
    await ref.read(urunNotifierProvider.notifier).refreshData();
    clearTextFieldCallback?.call();
  }

  VoidCallback? clearTextFieldCallback;

  void _registerClearCallback(VoidCallback callback) {
    clearTextFieldCallback = callback;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state1 = ref.watch(urunKaydetNotifierProvider);
    final stateUrun = ref.watch(urunNotifierProvider);
    final stateMarka = ref.watch(markaNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SafeArea(
          child: CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SearchBarScreen(
                        onInitClearCallback: _registerClearCallback,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        LocalizationHelper.l10n.markalar,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MarkaScreen(),
                      Text(
                        stateMarka.selectedMarka != null
                            ? '${stateMarka.selectedMarka!.orjName} ${LocalizationHelper.l10n.urunleriniz}'
                            : LocalizationHelper.l10n.tumurunler,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AnimationPleaseWaitContainerWidget(
                        isLoading: state1.isLoading,
                        metin: state1.metin,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: UrunListSliverWidget(),
              ),
              if (stateUrun.isNextLoading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
