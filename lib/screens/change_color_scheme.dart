import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_playground/extensions.dart";
import "package:flutter_playground/providers/color_provider.dart";
import "package:provider/provider.dart";

class UpdateColorSchemeScreen extends StatelessWidget {
  const UpdateColorSchemeScreen({super.key});

  String grabColor(String input) {
    var x = input.split(":");
    String color = (x[1].replaceAll("))", ")").trim());
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update ColorScheme"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: Colors.primaries.length + 1,
                  itemBuilder: (context, index) => index == 0
                      ? Consumer<ColorProvider>(
                          builder: (context, value, child) =>
                              SwitchListTile.adaptive(
                            value: value.isLightMode,
                            title: const Text("Toggle Brightness"),
                            inactiveTrackColor:
                                context.colorScheme.primary.withOpacity(0.2),
                            activeTrackColor: context.colorScheme.primary,
                            thumbIcon: MaterialStatePropertyAll(
                              value.isLightMode
                                  ? const Icon(Icons.sunny)
                                  : Icon(
                                      Icons.dark_mode_rounded,
                                      color: context.colorScheme.onBackground,
                                    ),
                            ),
                            onChanged: (isOn) => value.toggleBrightness(isOn),
                          ),
                        )
                      : Consumer<ColorProvider>(
                          builder: (context, value, child) => ListTile(
                            onTap: () {
                              value.updateFn(Colors.primaries[index - 1]);
                            },
                            tileColor: Colors.primaries[index - 1],
                            shape: const ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: Text("Color Scheme"),
                              child: Text(
                                grabColor(
                                    Colors.primaries[index - 1].toString()),
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                var colorVal = grabColor(
                                  Colors.primaries[index - 1].toString(),
                                );

                                ClipboardData data = ClipboardData(
                                  text: colorVal,
                                );
                                await Clipboard.setData(data);
                              },
                              tooltip: "Copy Color",
                              icon: const Icon(Icons.copy_rounded),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
