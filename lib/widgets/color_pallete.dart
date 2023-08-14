import 'package:flutter/material.dart';

import '../constants.dart';

class ColorPallete extends StatelessWidget {
  const ColorPallete({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final List<Color> colors = Constants.colors;
    return Center(
      child: Container(
        width: size.width * 0.5,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            colors.length,
            (index) => GestureDetector(
              onTap: () => Navigator.pop(context, colors[index].value),
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
