import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkrun_ar/widgets/draggable_bottom_sheet.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

class Testing2 extends StatelessWidget {
  const Testing2({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      children: [
        ListView(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          children: [
            Card(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              child: InkWell(
                onTap: () => print("hej"),
                child: RoundedExpansionTile(
                  leading: Icon(Icons.person),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  title: Text('Custom trailing with rotation'),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  rotateTrailing: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                          child: Text(
                            'Widget',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
