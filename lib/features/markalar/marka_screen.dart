import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/markalar/marka_notifier.dart';
import 'package:takip/features/markalar/widgets/shop_category.dart';

class MarkaScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MarkaScreenState();
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

        return SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allItems.length,
            itemBuilder: (context, index) {
              final marka = allItems[index];
              return MarkaWidget(title: marka.orjName, image: marka.link);
            },
          ),
        );
      },
    );
  }
}
