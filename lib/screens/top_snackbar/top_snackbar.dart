import "package:flutter/material.dart";
import "package:flutter_playground/extensions.dart";

class TopSnackbar extends StatelessWidget {
  const TopSnackbar({super.key});
  static OverlayEntry? overlayEntry;

  void showOverlay(BuildContext context) {
    final overlayState = Overlay.of(context);
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (context) {
          return CustomSnackbar(
            tapFn: () {
              overlayEntry?.remove();
              overlayEntry = null;
            },
          );
        },
      );
      overlayState.insert(overlayEntry!);
    } else {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FilledButton(
          onPressed: () {
            showOverlay(context);
          },
          child: const Text("Show Me"),
        ),
      ),
    );
  }
}

class CustomSnackbar extends StatefulWidget {
  const CustomSnackbar({
    super.key,
    required this.tapFn,
  });
  final Function() tapFn;

  @override
  State<CustomSnackbar> createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<CustomSnackbar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;
  double _dragOffsetY = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Durations.short4,
      debugLabel: "topsnackbar",
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
    super.initState();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffsetY += details.primaryDelta!;
      // Ensure the offset is between -1 (fully hidden) and 0 (fully visible)
      _dragOffsetY = _dragOffsetY.clamp(-200.0, 0.0);
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffsetY < -100) {
      // If dragged more than halfway, close the snackbar
      _controller.reverse().then((_) {
        widget.tapFn();
      });
    } else {
      // Otherwise, animate back to the fully visible state
      _controller.forward();
      setState(() {
        _dragOffsetY = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _dragOffsetY,
      left: 0,
      right: 0,
      child: Material(
        type: MaterialType.transparency,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: SlideTransition(
              position: _animation,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerHighest,
                ),
                padding: const EdgeInsets.all(10),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hey Nigger",
                        style: context.textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        "lorem ipsum is a simple dummy text of the printing and type setting industry",
                        style: context.textTheme.bodyMedium,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            _controller.reverse().then((_) {
                              widget.tapFn();
                            });
                          },
                          child: const Text("Close"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
