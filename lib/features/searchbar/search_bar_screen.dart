import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/features/link_yapistir/link_yapistir_screen.dart';
import 'package:takip/features/urunler/urun_notifier.dart';

class SearchBarScreen extends ConsumerStatefulWidget {
  final void Function(VoidCallback clearFunction) onInitClearCallback;
  const SearchBarScreen({super.key, required this.onInitClearCallback});

  @override
  ConsumerState<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends ConsumerState<SearchBarScreen> {
  Timer? _debounce;
  late final TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchController = TextEditingController();

    /// Clear fonksiyonunu parent’a ver
    widget.onInitClearCallback(() {
      _searchController.clear();
      _searchFocusNode.unfocus();
    });
    _searchController.addListener(() {
      setState(() {}); // Bu sayede suffixIcon güncellenir
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.unfocus();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: _searchFocusNode,
            controller: _searchController,
            onChanged: (value) async {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () async {
                await ref
                    .read(urunNotifierProvider.notifier)
                    .filterData(isQuery: true, query: value);
              });
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () async {
                        _searchController.clear();
                        _searchFocusNode.unfocus();
                        FocusScope.of(context).unfocus();
                        await ref
                            .read(urunNotifierProvider.notifier)
                            .filterData(isClearAll: true);
                      },
                    )
                  : SizedBox.shrink(),
              hintText: '${LocalizationHelper.l10n.ara} ...',
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
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 36),
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/icon/transparent_image.png',
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
