import 'package:flutter/material.dart';

class ColorSelectWidget extends StatefulWidget {
  final List<Color> colors;
  final void Function(Color selectedColor) onColorSelected;
  Color defaultColor;

  ColorSelectWidget({
    required this.colors,
    required this.onColorSelected,
    required this.defaultColor,
  });
  @override
  State<ColorSelectWidget> createState() => _ColorSelectWidgetState();
}

class _ColorSelectWidgetState extends State<ColorSelectWidget> {
  final focusNode = FocusNode();
  final layerLink = LayerLink();
  // late void Function(Color selectedColor) onColorSelected;
  Color? selectedColor;
  OverlayEntry? entry;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => hideOverlay());

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay();
      } else {
        hideOverlay();
      }
    });
  }

  showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
      builder: (context) => Positioned(
        //  width: size.width+40,
        // left: offset.dx-30,
        // right: 20,
        right: offset.dx - 20,
        top: offset.dy + size.height,
        child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 8),
            child: buildOverlay()),
      ),
    );
    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: ElevatedButton(
        focusNode: focusNode,
        // key: _buttonKey,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey.shade100)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Color:'),
            SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color:
                    selectedColor ?? widget.defaultColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        onPressed: () {
          showOverlay();
          // buildOverlay();
          setState(() {
            selectedColor = selectedColor;
          });
          focusNode.unfocus();
          // _showColorSelectionOverlay(context);
          // buildOverlay();
        },
      ),
    );
  }

  Widget buildOverlay() {
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.brown,
    ];

    return Material(
      elevation: 8,
      child: Container(
        
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 2,
                  blurRadius: 1.6,
                  offset: Offset(2, 5),
                ),
              ]),
          height: 50,
          width: 200,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 6,
            ),
            itemCount: colors.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              bool isSelected = colors[index] == selectedColor;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = colors[index];
                    buildOverlay();
                    focusNode.unfocus();
                  });
                  widget.onColorSelected(colors[index]);
                  hideOverlay();
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: colors[index],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected ? Colors.white : Colors.transparent,
                            width: isSelected ? 2.0 : 0.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )

          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: colors.map((color) {

          //     bool isSelected = color == selectedColor;
          //     return GestureDetector(
          //       onTap: () {
          //         setState(() {
          //           selectedColor = color;
          //           buildOverlay();
          //           focusNode.unfocus();
          //         });
          //         widget.onColorSelected(color);
          //         hideOverlay();

          //         // Navigator.of(context).pop();
          //       },
          //       child: Container(
          //         width: 40.0,
          //         height: 40.0,
          //         decoration: BoxDecoration(
          //           color: color,
          //           shape: BoxShape.circle,
          //           border: Border.all(
          //             color: isSelected ? Colors.black : Colors.transparent,
          //             width: isSelected ? 2.0 : 0.0,
          //           ),
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),

          ),
    );
  }
}
