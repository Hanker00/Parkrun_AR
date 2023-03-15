import 'package:flutter/material.dart';
import 'package:parkrun_ar/widgets/top_progress_info.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({super.key});

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableScrollableSheet(
        initialChildSize: .2,
        minChildSize: .1,
        maxChildSize: .9,
        builder: (BuildContext context, ScrollController scrollController) {
          // SingleChildScrollView makes sure the whole sheet scrolls together
          return SingleChildScrollView(
            controller: scrollController,
            // This container adds the coloured bar on top
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  // This column holds the actual content
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      // This row contains the small "scrollable" indicator
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            height: 8,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.amberAccent,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                TopProgressInfo(),
                // Additional Widgets go here
              ],
            ),
          );
        },
      ),
    );
  }
}
