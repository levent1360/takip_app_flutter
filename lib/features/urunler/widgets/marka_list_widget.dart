import 'package:flutter/material.dart';
import 'package:takip/features/markalar/widgets/shop_category.dart';

class MarkaListWidget extends StatelessWidget {
  const MarkaListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          MarkaWidget(
            title: "Women",
            image:
                "https://img.freepik.com/premium-vector/avatar-portrait-young-caucasian-woman-round-frame-vector-cartoon-flat-illustration_551425-22.jpg?semt=ais_hybrid&w=740",
          ),
          MarkaWidget(
            title: "Men",
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt_0plSJKNSdr-PRYr_V36bNZDdEa_TXeBqg&s",
          ),
          MarkaWidget(
            title: "Kids",
            image: "https://cdn-icons-png.flaticon.com/512/163/163807.png",
          ),
          MarkaWidget(
            title: "Shoes",
            image:
                "https://cdn.vectorstock.com/i/500p/43/21/stylish-black-canvas-shoes-vector-724321.jpg",
          ),
          MarkaWidget(
            title: "Beauty",
            image:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmqZLvYa5f8aLeZf4yw6aebd7KXK3cB23Y5Q&s",
          ),
        ],
      ),
    );
  }
}
