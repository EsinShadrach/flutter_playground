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
