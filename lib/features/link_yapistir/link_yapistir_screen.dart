import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/components/snackbar/error_snackbar_component.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/constant/lottie_files.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/shop_home_page.dart';
import 'package:takip/features/urunler/widgets/animation_please_wait_container_widget.dart';

class LinkYapistirScreen extends ConsumerStatefulWidget {
  const LinkYapistirScreen({super.key});

  @override
  ConsumerState<LinkYapistirScreen> createState() => _LinkYapistirScreenState();
}

class _LinkYapistirScreenState extends ConsumerState<LinkYapistirScreen> {
  final TextEditingController controller = TextEditingController();
  bool isCountCorrect = false;
  bool isResult = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _gonder() async {
    if (controller.text.isEmpty) {
      showErrorSnackBar(message: 'Boş gönderilemez');
      return;
    }

    // Sayfa geçişi işlemden sonra
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => ShopHomePage()));
    await ref
        .read(urunKaydetNotifierProvider.notifier)
        .urunKaydet2(context, controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final state1 = ref.watch(urunKaydetNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          LocalizationHelper.of(context).linkgonder,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  child: Lottie.asset(LottieFiles.packet, fit: BoxFit.contain),
                ),
                Container(
                  height: 100,
                  child: Center(
                    child: Text(
                      LocalizationHelper.of(context).takipyapistirmetin,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: LocalizationHelper.of(context).yapistirmetin,
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.link),
                    suffixIcon: TextButton(
                      onPressed: () async {
                        final clipboardData = await Clipboard.getData(
                          'text/plain',
                        );
                        if (clipboardData != null) {
                          controller.text = clipboardData.text ?? '';
                        }
                      },
                      child: Text(LocalizationHelper.of(context).yapistir),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: state1.isLoading ? null : _gonder,
                    icon: Icon(Icons.send),
                    label: Text(LocalizationHelper.of(context).gonder),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors
                                .grey; // disabled durumu için arka plan rengi
                          }
                          return Colors.teal; // normal durumda arka plan rengi
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>((
                        Set<MaterialState> states,
                      ) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors
                              .black38; // disabled durumu için yazı ve ikon rengi
                        }
                        return Colors
                            .white; // normal durumda yazı ve ikon rengi
                      }),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 16),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AnimationPleaseWaitContainerWidget(
                  isLoading: state1.isLoading,
                  metin: state1.metin,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
