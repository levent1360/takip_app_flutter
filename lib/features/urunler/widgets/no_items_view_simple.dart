import 'package:flutter/material.dart';
import 'package:takip/components/snackbar/error_snackbar_component.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/features/link_yapistir/link_yapistir_screen.dart';
import 'package:takip/features/markalar/marka_model.dart';
import 'package:takip/features/urunler/widgets/show_more_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NoItemsViewSimple extends StatefulWidget {
  final MarkaModel? selectedMarka;
  const NoItemsViewSimple({super.key, this.selectedMarka});

  @override
  State<NoItemsViewSimple> createState() => _NoItemsViewSimpleState();
}

class _NoItemsViewSimpleState extends State<NoItemsViewSimple> {
  void _launchURL() async {
    if (widget.selectedMarka != null) {
      final Uri url = Uri.parse("https://${widget.selectedMarka!.homeLink}");
      // En önemli nokta: LaunchMode.externalApplication
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Link açılamadı: $url');
      }
    } else {
      showErrorSnackBar(message: LocalizationHelper.l10n.markabulunamadi);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LocalizationHelper.l10n.urunlinkinipaylas,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false, // ŞART: Arka planı şeffaf yapar
                            pageBuilder: (_, __, ___) =>
                                const LinkYapistirScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                widget.selectedMarka != null
                    ? GestureDetector(
                        onTap: _launchURL,
                        child: Text(
                          '${widget.selectedMarka?.orjName} ${LocalizationHelper.l10n.urunsitesinegit}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       TextSpan(
            //         style: TextStyle(
            //           fontSize: 18,
            //           color: Colors.grey.shade700,
            //           fontWeight: FontWeight.w500,
            //         ),
            //         text: widget.selectedMarka != null
            //             ? '${LocalizationHelper.l10n.uruneklememetni_markali("Zara").split('+')[0]}'
            //             : '${LocalizationHelper.l10n.uruneklememetni.split('+')[0]}',
            //       ),
            //       TextSpan(
            //         text: '+',
            //         style: TextStyle(
            //           fontSize: 28,
            //           color: Colors.teal,
            //           fontWeight: FontWeight.w800,
            //         ),
            //       ),
            //       TextSpan(
            //         style: TextStyle(
            //           fontSize: 18,
            //           color: Colors.grey.shade700,
            //           fontWeight: FontWeight.w500,
            //         ),
            //         text: widget.selectedMarka != null
            //             ? '${LocalizationHelper.l10n.uruneklememetni_markali(widget.selectedMarka!.orjName).split('+')[1]}'
            //             : '${LocalizationHelper.l10n.uruneklememetni.split('+')[1]}',
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ),
        ShowMoreWidget(),
      ],
    );
  }
}
