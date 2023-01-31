import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_excel_data_app/home_screen/home_cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Excel Data Shower'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    itemCount: homeCubit.data.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < homeCubit.data[index].length; i++)
                            Text(
                              homeCubit.data[index][i].toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: homeCubit.importData,
              child: Icon(
                Icons.drive_folder_upload,
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
// this code for excel files but from assets

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class XLSDataPage extends StatefulWidget {
  @override
  _XLSDataPageState createState() => _XLSDataPageState();
}

class _XLSDataPageState extends State<XLSDataPage> {
  List<List<dynamic>> data=[];
  String? filePath;

  @override
  void initState() {
    super.initState();
    _importData();
  }

  void _importData() async {
    var file = await rootBundle.load('assets/xlsfile.xlsx');
    var bytes = Uint8List.view(file.buffer);
    var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
    var sheet = decoder.tables.values.first;
    data = sheet.rows;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == []
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index][0].toString()),
            subtitle: Text(data[index][1].toString()),
          );
        },
      ),
    );
  }
}

*/
