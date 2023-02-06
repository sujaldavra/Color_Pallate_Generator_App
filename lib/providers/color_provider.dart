import 'dart:convert';

import 'package:color_pallate_generator/modals/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorProvider extends ChangeNotifier {
  List<ColorPaletteGenerator> colorsList = [];
  bool isDataLoad = true;
  ColorPaletteGenerator colorPalette = ColorPaletteGenerator(
    color100: "0xff737373",
    color200: "0xff5C5C5C",
    color400: "0xff454545",
    color600: "0xff2E2E2E",
    color800: "0xff171717",
    color900: "0xff000000",
  );

  loadData() async {
    if (isDataLoad) {
      String json = await rootBundle.loadString("assets/json/colorPallate.json");
      List data = jsonDecode(json);
      colorsList = data.map((e) => ColorPaletteGenerator.fromJson(e)).toList();
      isDataLoad = false;
    }
  }

  changeColorPaletteGenerator() {
    colorsList.shuffle();
    colorPalette = colorsList.first;
    notifyListeners();
  }
}
