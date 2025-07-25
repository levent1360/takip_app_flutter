import 'package:flutter/material.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/features/markalar/marka_model.dart';

class NoItemsViewSimple extends StatefulWidget {
  MarkaModel? selectedMarka;
  NoItemsViewSimple({super.key, this.selectedMarka});

  @override
  State<NoItemsViewSimple> createState() => _NoItemsViewSimpleState();
}

class _NoItemsViewSimpleState extends State<NoItemsViewSimple> {
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
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                    text: widget.selectedMarka != null
                        ? '${LocalizationHelper.l10n.uruneklememetni_markali("Zara").split('+')[0]}'
                        : '${LocalizationHelper.l10n.uruneklememetni.split('+')[0]}',
                  ),
                  TextSpan(
                    text: '+',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.teal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                    text: widget.selectedMarka != null
                        ? '${LocalizationHelper.l10n.uruneklememetni_markali(widget.selectedMarka!.orjName).split('+')[1]}'
                        : '${LocalizationHelper.l10n.uruneklememetni.split('+')[1]}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
