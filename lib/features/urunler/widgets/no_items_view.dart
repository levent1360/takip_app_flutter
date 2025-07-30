import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/components/snackbar/error_snackbar_component.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/constant/lottie_files.dart';
import 'package:takip/features/markalar/marka_model.dart';
import 'package:takip/features/urun_kaydet/widgets/link_paylasim_yardim_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class NoItemsView extends StatefulWidget {
  final MarkaModel? selectedMarka;
  const NoItemsView({super.key, this.selectedMarka});

  @override
  State<NoItemsView> createState() => _NoItemsViewState();
}

class _NoItemsViewState extends State<NoItemsView> {
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
      children: [
        Container(
          height: 100,
          width: 150,
          child: Lottie.asset(LottieFiles.noitem, fit: BoxFit.contain),
        ),
        const SizedBox(height: 32),
        Text(
          LocalizationHelper.l10n.urunbulunamadi,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        if (widget.selectedMarka != null)
          Center(
            child: ElevatedButton(
              onPressed: _launchURL,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                backgroundColor: Colors.teal,
              ),
              child: Text(
                style: TextStyle(color: Colors.white),
                "${widget.selectedMarka!.orjName} ${LocalizationHelper.l10n.markasiteyegit}",
              ),
            ),
          ),

        const SizedBox(height: 20),
        LinkPaylasimYardimIcerik(),
      ],
    );
  }
}
