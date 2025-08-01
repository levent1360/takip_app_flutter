import 'package:flutter/material.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/features/urun_kaydet/widgets/link_paylasim_yardim_screen_simple.dart';

class ShowMoreWidget extends StatefulWidget {
  @override
  _ShowMoreWidgetState createState() => _ShowMoreWidgetState();
}

class _ShowMoreWidgetState extends State<ShowMoreWidget> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: Row(
            children: [
              Expanded(
                child: Divider(thickness: 1, color: Colors.grey, endIndent: 10),
              ),
              Text(
                _isExpanded
                    ? LocalizationHelper.l10n.dahaaz
                    : LocalizationHelper.l10n.dahafazlabilgi,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Divider(thickness: 1, color: Colors.grey, indent: 10),
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: LinkPaylasimYardimScreenSimple(),
          ),
          secondChild: SizedBox.shrink(),
        ),
      ],
    );
  }
}
