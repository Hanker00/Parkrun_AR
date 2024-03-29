import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';

class DraggableBottomSheet extends StatefulWidget {
  final List<Widget> children;
  final double intialSize;
  final double minSize;
  final double maxSize;
  const DraggableBottomSheet(
      {super.key,
      required this.children,
      required this.intialSize,
      required this.minSize,
      required this.maxSize});

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget
          .intialSize, //this should depend on the height od the current step
      minChildSize: widget.minSize, // only current sign and buttons showing
      maxChildSize: widget.maxSize, // whole screen
      builder: (BuildContext context, ScrollController scrollController) {
        // SingleChildScrollView makes sure the whole sheet scrolls together
        return SingleChildScrollView(
          controller: scrollController,
          // This container adds the coloured bar on top
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: colorPrimary,
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
                              color: colorPrimaryLight),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: widget.children,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
