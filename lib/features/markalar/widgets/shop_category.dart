import 'package:flutter/material.dart';
import 'package:takip/components/image/network_image_with_loader.dart';
import 'package:takip/features/markalar/marka_model.dart';

class MarkaWidget extends StatelessWidget {
  final MarkaModel marka;
  final bool isSelected;
  final bool isFiltered;
  final void Function(MarkaModel) onTap;
  const MarkaWidget({
    Key? key,
    required this.marka,
    required this.isSelected,
    required this.isFiltered,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () => onTap(marka),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isFiltered
                      ? isSelected
                            ? Colors.blue
                            : Colors.transparent
                      : Colors.transparent,
                  // Border rengini burada belirliyoruz
                  width: 2, // Border'ın kalınlığını ayarlayabilirsiniz
                ),
              ),
              child: CircleAvatar(
                backgroundColor:
                    Colors.deepPurple[isFiltered && isSelected ? 100 : 50],
                radius: 28,
                child: NetworkImageWithLoader(marka.link),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              marka.orjName,
              style: TextStyle(
                fontSize: 12,
                color: isFiltered
                    ? isSelected
                          ? Colors.black
                          : Colors.black45
                    : Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
