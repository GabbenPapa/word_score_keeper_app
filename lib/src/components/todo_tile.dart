import 'package:flutter/material.dart';

class CollectedListTile extends StatelessWidget {
  final String listText;

  const CollectedListTile({
    super.key,
    required this.listText,
  });

  @override
  Widget build(BuildContext context) {
    String scoreText = 'Score: ${listText.length}';

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              listText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(scoreText),
          ],
        ),
      ),
    );
  }
}
