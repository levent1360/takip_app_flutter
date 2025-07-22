import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/features/markalar/marka_notifier.dart';
import 'package:takip/features/markalar/marka_screen.dart';
import 'package:takip/features/searchbar/search_bar_screen.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/widgets/animation_please_wait_container_widget.dart';
import 'package:takip/features/urunler/widgets/urun_list_widget.dart';

class ShopHomePage2 extends ConsumerStatefulWidget {
  const ShopHomePage2({super.key});

  @override
  ConsumerState<ShopHomePage2> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends ConsumerState<ShopHomePage2> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      ref.read(urunNotifierProvider.notifier).nextData();
    }
  }

  Future<void> refresh() async {
    ref.read(urunNotifierProvider.notifier).initData();
  }

  Future<void> deleteOnboardingSeen() async {
    final localDataSource = sl<LocalDataSource>();
    await localDataSource.deleteOnboardingSeen();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 10),
                    // Search Bar
                    SearchBarScreen(),
                    const SizedBox(height: 10),

                    // Shop Markets
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalizationHelper.l10n.markalar,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text('Hepsi', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    MarkaScreen(),
                    const SizedBox(height: 5),
                    // Popular Items
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stateMarka.selectedMarka != null
                              ? '${stateMarka.selectedMarka!.orjName} ${LocalizationHelper.l10n.urunleriniz}'
                              : '${LocalizationHelper.l10n.tumurunler}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Text('Hepsi', style: TextStyle(color: Colors.grey)),
                        //   ],
                        // ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    AnimationPleaseWaitContainerWidget(
                      isLoading: state1.isLoading,
                      metin: state1.metin,
                    ),
                    UrunListWidget(),
                    const SizedBox(height: 30),
                  ],
                ),
                if (stateUrun.isNextLoading)
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
