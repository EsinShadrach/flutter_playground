import "package:flutter/material.dart";

class OverlayScreenExample extends StatefulWidget {
  const OverlayScreenExample({super.key});

  @override
  State<OverlayScreenExample> createState() => _OverlayScreenExampleState();
}

class _OverlayScreenExampleState extends State<OverlayScreenExample> {
  final GlobalKey _iconKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    // uncomment this to show the red dot on the icon widget after the widget is rendered
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _findWidgetPositionAndShowOverlay();
    // });
    super.initState();
  }

  void _findWidgetPositionAndShowOverlay() {
    final RenderBox? renderBox =
        _iconKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final Offset position = renderBox.localToGlobal(Offset.zero);
      _showOverlay(position);
    }
  }

  void _showOverlay(Offset position) {
    final OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 7,
        top: position.dy + 6,
        child: const RedDot(),
      ),
    );
    overlayState.insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: IconWidget(
                key: _iconKey,
              ),
            ),
            FilledButton(
              onPressed: () {
                _findWidgetPositionAndShowOverlay();
              },
              child: const Text("Show Red Dot"),
            ),
          ],
        ),
      ),
    );
  }
}

class RedDot extends StatelessWidget {
  const RedDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.tv,
    );
  }
}
