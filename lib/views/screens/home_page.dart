import 'package:color_pallate_generator/modals/color.dart';
import 'package:color_pallate_generator/providers/color_provider.dart';
import 'package:color_pallate_generator/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ColorPaletteGenerator colorPalette;
  @override
  Widget build(BuildContext context) {
    Provider.of<ColorProvider>(context, listen: false).loadData();
    colorPalette = Provider.of<ColorProvider>(context).colorPalette;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Color Palette Generator",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeThemes();
            },
            icon: Icon(
              (Provider.of<ThemeProvider>(context).isDark)
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            customContainer(color: colorPalette.color100, isFirst: true),
            customContainer(color: colorPalette.color200),
            customContainer(color: colorPalette.color400),
            customContainer(color: colorPalette.color600),
            customContainer(color: colorPalette.color800),
            customContainer(color: colorPalette.color900, isLast: true),
            const Spacer(),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: (Provider.of<ThemeProvider>(context).isDark)
                    ? const BorderSide(color: Colors.white, width: 2)
                    : const BorderSide(color: Colors.black, width: 2),
              ),
              onPressed: () {
                Provider.of<ColorProvider>(context, listen: false)
                    .changeColorPaletteGenerator();
              },
              child: (Provider.of<ThemeProvider>(context).isDark)
                  ? const Text(
                      'Color Change',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  : const Text(
                      'Color Change',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  customContainer({bool? isFirst, bool? isLast, required String color}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular((isFirst != null) ? 50 : 0),
          topRight: Radius.circular((isFirst != null) ? 50 : 0),
          bottomRight: Radius.circular((isLast != null) ? 50 : 0),
          bottomLeft: Radius.circular((isLast != null) ? 50 : 0),
        ),
        color: Color(int.parse(color)),
      ),
    );
  }
}
