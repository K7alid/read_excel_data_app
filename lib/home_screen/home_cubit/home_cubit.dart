import 'dart:io';
import 'dart:typed_data';

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

  void importDataForMobile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['xlsx']);

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

  void importDataForWeb() async {
    final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['xlsx']);

    if (pickedFile == null) return;
    print(pickedFile.files.first.name);

    Uint8List? uploadfile = pickedFile.files.single.bytes;

    Uint8List bytes = uploadfile!;

    var decoder = SpreadsheetDecoder.decodeBytes(
      bytes,
      update: true,
    );
    var sheet = decoder.tables.values.first;
    data = sheet.rows;
    emit(ShowExcelDataState());
  }
}
