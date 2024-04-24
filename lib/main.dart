import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_playground/extensions.dart";
import "package:flutter_playground/providers/color_provider.dart";
import "package:flutter_playground/routes.dart";
import "package:flutter_playground/screens/change_color_scheme.dart";
import "package:provider/provider.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorProvider>(
      builder: (context, value, child) => MaterialApp(
        title: "Flutter Demo",
        routes: routes(),
        debugShowCheckedModeBanner: false,
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text("Page not found"),
              ),
            ),
          );
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: value.appTheme,
            brightness: value.isLightMode ? Brightness.light : Brightness.dark,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String convertMapToString(String data) {
      if (data == "/") {
        return "home";
      }

      // Firstly remove the slash
      String removedSlash = data.replaceAll("/", " ");

      // Convert all - to space
      String removedDash = removedSlash.replaceAll("-", " ").trim();

      // Convert to title case
      var toTitleCase = removedDash
          .split(" ")
          .map(
            (e) => e.substring(0, 1).toUpperCase() + e.substring(1),
          )
          .join(" ");
      return toTitleCase;
    }

    var currentRoute = ModalRoute.of(context)!.settings.name ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(convertMapToString(currentRoute)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UpdateColorSchemeScreen(),
                  fullscreenDialog: true,
                  barrierDismissible: true,
                ),
              );
            },
            icon: Icon(
              Icons.color_lens,
              color: context.colorScheme.primary,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              backgroundColor:
                  context.colorScheme.inverseSurface.withOpacity(0.02),
              header: SizedBox(
                width: double.infinity,
                child: Text(
                  "Widgets I think are cool",
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              children: List.generate(routes().length, (index) {
                String route = routes().keys.toList()[index];
                String pushRoute = routes().keys.toList()[index];
                bool isPresentActiveRoute = currentRoute == pushRoute;

                return CupertinoListTile.notched(
                  leading: Container(
                    height: 20,
                    width: 20,
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: Colors.primaries[index % Colors.primaries.length],
                    ),
                  ),
                  // Don't know why i used a stack here
                  title: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Text(
                        convertMapToString(route),
                        style: context.textTheme.bodyLarge,
                      ),
                      if (!isPresentActiveRoute) ...[
                        const GlowingBadge(),
                      ],
                    ],
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: isPresentActiveRoute
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(pushRoute);
                        },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class GlowingBadge extends StatelessWidget {
  const GlowingBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -7,
      top: 0,
      child: Container(
        width: 7,
        height: 7,
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}
