# Flutter Playground

## Introduction

Welcome to Flutter Playground, a space for exploring Flutter projects and experimenting with various features of the framework. This repository includes a collection of Flutter examples, including a page animation demo.

## Table of Contents

- [Page Animation](#page-animation)
- [Animated List](#animated-list)
- [Scale Down Button](#scale-down-button)
- [Overlay Example](#overlay-example)
- [Other Routes](#other-routes)
- [Setup](#setup)
- [Contribute](#contribute)
- [License](#license)

## Page Animation

The `Page Animation` example demonstrates a page transition animation using the `PageRouteBuilder` and `SlideTransition`. It comprises two screens - the first screen with a button to navigate to the second screen. The animation is achieved by sliding the first screen out from the bottom. Explore the code and run the app to see the animation in action.

## Demo Video [Page Animation](#page-animation)

Watch the demo video:

https://github.com/EsinShadrach/flutter_playground/assets/102266348/88366ddd-2787-4b0c-a41f-c8d6999deb17

## Animated List

The `Animated List` example showcases how to create an animated list in Flutter. It includes various animations for adding, removing, and updating list items.

### How it Works

- The example consists of a `StatefulWidget` called `AnimatedListScreen`.
- Inside the `AnimatedListScreen`, we have a `List<String>` called `names`, which stores the list items.
- The `AnimatedList` widget is used to display the list of names with animations.
- List items can be added by tapping the "Add One" button. This triggers an animation where the new item is inserted at the top of the list.
- List items can be removed by tapping the remove icon next to each item. This triggers an animation where the item is removed from the list.
- Additionally, the entire list can be cleared by pulling down to refresh, triggering an animation where all items are removed from the list simultaneously.

### Implementation Details

- The list is wrapped inside a `SafeArea` and a `Padding` widget for better spacing.
- A `RefreshIndicator` is used to enable pull-to-refresh functionality, which triggers the removal of all list items.
- Each list item is represented by a `ListTile` widget, with a leading remove icon and a trailing add icon.
- Animation for adding and removing list items is achieved using the `AnimatedListState` and `SlideTransition`.
- When adding a new item, it's inserted into the list and animated in from the top.
- When removing an item, it's removed from the list and animated out towards the bottom.

### Usage

To see the Animated List in action, run the Flutter app and navigate to the Animated List screen. Interact with the buttons to add or remove list items, and pull down to refresh to clear the list.

### Code

The code snippet below shows the implementation of the Animated List example:

```dart
import "package:flutter/material.dart";
import "package:flutter_playground/extensions.dart";

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<String> names = [
    "Rafe",
    "Esin",
    "Shadrach",
  ];

  void addToNames(String name, int index) {
    _listKey.currentState!.insertItem(
      index,
      duration: const Duration(milliseconds: 500),
    );

    setState(() {
      names.add("$name-$index");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              _listKey.currentState!.removeAllItems(
                (context, animation) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                ),
              );
              names.clear();
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          names.add("New name");
                          _listKey.currentState!.insertItem(
                            0,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        child: const Text("Add One"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: names.length,
                    itemBuilder: (context, index, animation) => SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              _listKey.currentState!.removeItem(
                                index,
                                (context, animation) => SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                ),
                              );
                            },
                            icon: const Icon(Icons.remove_rounded),
                          ),
                          tileColor:
                              context.colorScheme.primary.withOpacity(0.2),
                          trailing: IconButton(
                            onPressed: () {
                              addToNames("New Name", index);
                            },
                            icon: const Icon(Icons.add_rounded),
                          ),
                          shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          title: Text(names[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## Scale Down Button

The `Scale Down Button` example demonstrates how to create a button that scales down in size when pressed. It utilizes animation to provide visual feedback to the user.

### How it Works

- The example consists of a `StatelessWidget` called `ScaleDownButton`.
- Inside the `ScaleDownButton`, there's a `BouncingBtn` widget that creates the button with the desired scaling effect.
- When the button is tapped down, it triggers an animation that scales down the button.
- When the button is released or the tap is canceled, it returns to its original size.

### Implementation Details

- The button animation is achieved using a combination of `GestureDetector`, `AnimationController`, `Tween`, and `ScaleTransition`.
- A `Padding` widget is used to add some spacing around the button.
- The `onPressed` callback is triggered when the button is pressed and released, showing a `SnackBar` with a "Hello" message.

### Usage

To see the Scale Down Button in action, run the Flutter app and navigate to the Scale Down Button screen. Tap the button to experience the scaling effect.

### Code

The code snippet below shows the implementation of the Scale Down Button example:

```dart
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
```

## Overlay Example

The `Overlay Example` demonstrates the usage of overlays in Flutter. It showcases how to overlay widgets on top of other widgets dynamically.

### How it Works

- The example consists of a `StatefulWidget` called `OverlayScreenExample`.
- Inside the `OverlayScreenExample`, there's a button that, when pressed, triggers the display of a red dot overlay on top of an icon widget.
- The overlay functionality is implemented using the `Overlay` and `OverlayEntry` classes provided by Flutter.
- When the button is pressed, the position of the icon widget is determined, and a red dot overlay is displayed at that position.

### Implementation Details

- The red dot overlay is created using a `RedDot` widget, which simply renders a red circle.
- The icon widget is represented by an `IconWidget`, which displays an icon (in this case, the TV icon).
- The overlay logic is implemented in the `showOverlay` method, where an `OverlayEntry` is created with the red dot widget positioned relative to the icon widget.
- The overlay is removed when the widget is disposed of to prevent memory leaks.

### Usage

To see the Overlay Example in action, run the Flutter app and navigate to the Overlay Example screen. Tap the "Show Red Dot" button to display the red dot overlay on top of the icon widget.

### Code

The code snippet below shows the implementation of the Overlay Example:

```dart
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
```

## Other Routes

Additional routes in the repository can be explored for various widgets and features. The `HomePage` class in the main Flutter app dynamically generates a list of available routes.

## Setup

To run this project locally, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/EsinShadrach/flutter_playground
   cd flutter_playground
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

## Contribute

Feel free to contribute by adding your own Flutter projects, improving existing ones, or exploring different Flutter features. Follow the contributing guidelines in the repository.

## License

This Flutter Playground is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
