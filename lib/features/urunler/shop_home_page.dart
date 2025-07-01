import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/features/markalar/marka_screen.dart';
import 'package:takip/features/searchbar/search_bar_screen.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/widgets/animation_please_wait_container_widget.dart';
import 'package:takip/features/urunler/widgets/urun_list_widget.dart';

class ShopHomePage extends ConsumerStatefulWidget {
  const ShopHomePage({super.key});

  @override
  ConsumerState<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends ConsumerState<ShopHomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> getProducts() async {
    ref.read(urunNotifierProvider.notifier).getProducts();
  }

  Future<void> deleteOnboardingSeen() async {
    final localDataSource = sl<LocalDataSource>();
    await localDataSource.deleteOnboardingSeen();
  }

  @override
  Widget build(BuildContext context) {
    final state1 = ref.watch(urunKaydetNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              // Search Bar
              SearchBarScreen(),
              const SizedBox(height: 15),

              // Shop Markets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Markalar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Hepsi', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),
              MarkaScreen(),
              const SizedBox(height: 10),
              // Popular Items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ürünleriniz',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text('Hepsi', style: TextStyle(color: Colors.grey)),
                      IconButton(
                        onPressed: getProducts,
                        icon: Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: deleteOnboardingSeen,
                        icon: Icon(Icons.remove),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AnimationPleaseWaitContainerWidget(isLoading: state1.isLoading),
              UrunListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
