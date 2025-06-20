import 'package:flutter/material.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/services/urun_service.dart';
import 'package:takip/features/urunler/model/urun_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
    _productsFuture = sl<UrunService>().getProducts();
    print(_productsFuture);
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
                children: const [
                  Text(
                    'Shop Markets',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('See All', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ShopCategory(
                      title: "Women",
                      image:
                          "https://img.freepik.com/premium-vector/avatar-portrait-young-caucasian-woman-round-frame-vector-cartoon-flat-illustration_551425-22.jpg?semt=ais_hybrid&w=740",
                    ),
                    ShopCategory(
                      title: "Men",
                      image:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt_0plSJKNSdr-PRYr_V36bNZDdEa_TXeBqg&s",
                    ),
                    ShopCategory(
                      title: "Kids",
                      image:
                          "https://cdn-icons-png.flaticon.com/512/163/163807.png",
                    ),
                    ShopCategory(
                      title: "Shoes",
                      image:
                          "https://cdn.vectorstock.com/i/500p/43/21/stylish-black-canvas-shoes-vector-724321.jpg",
                    ),
                    ShopCategory(
                      title: "Beauty",
                      image:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmqZLvYa5f8aLeZf4yw6aebd7KXK3cB23Y5Q&s",
                    ),
                  ],
                ),
              ),

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
              FutureBuilder<List<UrunModel>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Hata: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Ürün bulunamadı"));
                  }

                  final urunler = snapshot.data!;

                  return GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                    children: urunler.map((urun) {
                      return ProductCard(
                        image:
                            urun.eImg ??
                            "https://via.placeholder.com/150", // varsayılan resim
                        title: urun.name,
                        price: urun.firstPrice,
                        oldPrice: urun.lastPrice,
                        url: urun.link, // örnek olarak eski fiyat
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopCategory extends StatelessWidget {
  final String title;
  final String image;
  const ShopCategory({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(radius: 28, child: Image.network(image)),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final int price;
  final int oldPrice;
  final String url;
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.url,
  });

  void gotoUrl() async {
    final Uri _url = Uri.parse(this.url.toString());
    print('_url = $_url');

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, mode: LaunchMode.platformDefault);
    } else {
      print('URL açılamadı!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Icon(Icons.favorite_border),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  "\$$price",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                Text(
                  "\$$oldPrice",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: gotoUrl,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
