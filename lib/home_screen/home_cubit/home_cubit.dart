import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<List<dynamic>> data = [];
  String? _filePath;

  void importData() async {
    final pickedFile =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (pickedFile == null) return;
    print(pickedFile.files.first.name);

    _filePath = pickedFile.files.first.path;
    var file = File.fromUri(Uri.file(_filePath!));
    var bytes = await file.readAsBytes();
    var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
    var sheet = decoder.tables.values.first;
    data = sheet.rows;
    emit(ShowExcelDataState());
  }
}
