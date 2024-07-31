import "package:flutter/material.dart";

class StickyHeaderScreen extends StatelessWidget {
  const StickyHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StickyHeaderExample();
  }
}

class StickyHeaderExample extends StatelessWidget {
  const StickyHeaderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text("Item $index"),
                );
              },
              childCount: 50, // Adjust this to change the number of list items
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _StickyHeaderDelegate(
              minHeight: 60.0,
              maxHeight: 60.0,
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 30,
                ),
                child: const SafeArea(
                  child: Center(
                    child: Text(
                      "Pinned Header",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // This is the scrollable content
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text("Item $index"),
                );
              },
              childCount: 50, // Adjust this to change the number of list items
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
