import "package:flutter/material.dart";
import "package:flutter_playground/extensions.dart";
import "package:lucide_icons/lucide_icons.dart";

class StackedCards extends StatelessWidget {
  const StackedCards({super.key});
  static String text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget orci nec nisl viverra porta. Sed a velit tincidunt, sagittis tortor congue, finibus sem. Nam facilisis laoreet ante. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam ac eros sagittis dui consectetur interdum a posuere velit. Maecenas mi felis, molestie eget lorem in, rutrum tempus arcu. Quisque a dui in arcu tristique posuere non sit amet justo. Duis pellentesque hendrerit tempor. Quisque scelerisque sapien eu porta condimentum. Phasellus bibendum malesuada auctor. Vivamus pretium pellentesque enim, non aliquam orci iaculis eu. Praesent feugiat porttitor ultricies. Duis porttitor, dui ac tempus tincidunt, libero massa vulputate massa, sit amet molestie est augue eu enim. Phasellus vel dignissim eros. Fusce accumsan eu magna at faucibus. Duis sit amet dictum ex. Curabitur ultrices iaculis dui non eleifend. Phasellus velit sem, mollis id fringilla ut, ornare at dolor. Fusce ligula neque, mattis id porttitor eget, efficitur a ipsum. In commodo felis vel sollicitudin tempus. Maecenas eget scelerisque nibh. Proin aliquam augue non erat aliquam aliquam. Phasellus gravida consequat convallis. Aenean vitae cursus urna. Maecenas orci erat, condimentum at pretium in, lobortis a sapien. Quisque iaculis lacus consequat nisi pulvinar egestas. Ut at finibus erat, in eleifend mauris. Proin et ornare est, a vulputate sapien. Sed augue ipsum, vestibulum nec vestibulum ut, efficitur at diam. Fusce mi felis, laoreet non sodales eget, pharetra ut dolor. Nunc id pretium orci. Aliquam mattis tempor aliquet. Sed ex ante, lobortis id felis vel, posuere mollis eros. Aliquam vel libero diam. Nunc a purus volutpat, efficitur dui sit amet, rutrum odio. Mauris sollicitudin magna vitae pretium molestie. Praesent sit amet odio nisl. Sed eget convallis ex. Pellentesque ornare tortor quis luctus hendrerit. Ut viverra condimentum quam ac porta. Phasellus tempor, eros vel consequat aliquam, augue ante accumsan diam, non porta erat erat sit amet massa. Vivamus mattis magna eu ultricies elementum.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stacked Cards Example"),
      ),
      body: SafeArea(
        child: Stack(
          children: List.generate(
            3,
            (index) {
              return Positioned.fill(
                left: index * 10,
                bottom: index * 10,
                child: NoteCard(
                  body: text,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.body,
  });
  final String body;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 400,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              width: 1,
              color: context.colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      "Fashion AI",
                      style: context.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton.filled(
                      onPressed: () {
                        context.showSnackBar(
                          const SnackBar(
                            content: Text("TODO: Implement PIN"),
                          ),
                        );
                      },
                      icon: Transform.rotate(
                        angle: 0.5,
                        child: const Icon(LucideIcons.pin),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton.filled(
                      onPressed: () {
                        context.showSnackBar(
                          const SnackBar(
                            content: Text("TODO: Implement EDIT"),
                          ),
                        );
                      },
                      icon: const Icon(LucideIcons.edit3),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    body,
                    maxLines: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Row(
                  children: <Widget>[
                    const Chip(
                      label: Text("name"),
                      avatar: Icon(LucideIcons.clock2),
                    ),
                    const Spacer(),
                    IconButton.filledTonal(
                      color: context.colorScheme.onError,
                      style: IconButton.styleFrom(
                        backgroundColor: context.colorScheme.error,
                      ),
                      onPressed: () {
                        //
                      },
                      icon: const Icon(LucideIcons.trash),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
