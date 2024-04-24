import "package:flutter/material.dart";
import "package:flutter_playground/extensions.dart";

class ScaleDownButton extends StatelessWidget {
  const ScaleDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scale down button"),
      ),
      body: SafeArea(
        child: Center(
          child: BouncingBtn(
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              context.showSnackBar(
                const SnackBar(
                  content: Text("Hello"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BouncingBtn extends StatefulWidget {
  const BouncingBtn({
    super.key,
    required this.onPressed,
  });
  final void Function() onPressed;

  @override
  State<BouncingBtn> createState() => _BouncingBtnState();
}

class _BouncingBtnState extends State<BouncingBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.3,
      duration: Durations.short4,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTapDown: (details) {
          _controller.forward();
        },
        onTapUp: (details) {
          _controller.reverse();
        },
        onTapCancel: () {
          _controller.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FilledButton(
            onPressed: () {
              widget.onPressed();
            },
            child: const Text("Hello"),
          ),
        ),
      ),
    );
  }
}
