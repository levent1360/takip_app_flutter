import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/link_yapistir/link_yapistir_screen.dart';
import 'package:takip/features/notification/bildirim_screen.dart';
import 'package:takip/features/urunler/urun_notifier.dart';

class SearchBarScreen extends ConsumerStatefulWidget {
  const SearchBarScreen({super.key});

  @override
  ConsumerState<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends ConsumerState<SearchBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              ref.read(urunNotifierProvider.notifier).filterProducts(value);
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Ara ...',
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
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false, // ŞART: Arka planı şeffaf yapar
                pageBuilder: (_, __, ___) => const LinkYapistirScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.qr_code_scanner),
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const BildirimScreen()));
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.notifications),
          ),
        ),
      ],
    );
  }
}
