import 'package:flutter/material.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/services/urun_service.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:takip/features/urunler/widgets/marka_list_widget.dart';
import 'package:takip/features/urunler/widgets/urun_list_widget.dart';

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({super.key});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  late Future<List<UrunModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    getProducts();
    print(_productsFuture);
  }

  Future<void> getProducts() async {
    _productsFuture = sl<UrunService>().getProducts();
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
              UrunListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
