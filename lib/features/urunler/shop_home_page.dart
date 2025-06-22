import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/widgets/marka_list_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.qr_code_scanner),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Shop Markets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop Markets',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('See All', style: TextStyle(color: Colors.grey)),
                  IconButton(
                    onPressed: () async {
                      await getProducts();
                      setState(() {});
                    },
                    icon: Icon(Icons.refresh),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MarkaListWidget(),

              const SizedBox(height: 20),
              // Popular Items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Popular Items',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('See All', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(child: UrunListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
