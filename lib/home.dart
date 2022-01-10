import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/drawer.dart';
import 'package:ocr/utils.dart';
import 'package:share/share.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _scanning = false;
  String _extractText = '';
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  late var langCode = [
    "amh",
    "chi_sim",
    "eng",
    "fra",
    "hin",
    "ita",
    "jpn",
    "kor",
    "lat",
    "rus",
    "spa",
    "swa",
    "tir",
    "tur"
  ];
  late var languages = [
    "Amharic",
    "Chinese",
    "English",
    "French",
    "Hindi",
    "Italian",
    "Japanese",
    "Korean",
    "Latin",
    "Russian",
    "Spanish",
    "Swahili",
    "Tigrinya",
    "Turkish"
  ];
  late String lang = "amh";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
        ),
        drawer: DrawerWidget(),
        body: ListView(
          shrinkWrap: true,
          children: [
            _pickedImage == null
                ? Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image,
                      size: 100,
                    ),
                  )
                : Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: DecorationImage(
                          image: FileImage(File(_pickedImage!.path)),
                          fit: BoxFit.fill,
                        )),
                  ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Select Language"),
                        DropdownButton(
                          value: lang,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: langCode.map((String items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  languages[langCode.indexOf(items)],
                                  overflow: TextOverflow.clip,
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              lang = newValue.toString();
                              print(lang);
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Select image"),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.redAccent)),
                          child: Icon(Icons.image),
                          onPressed: () async {
                            setState(() {
                              _scanning = true;
                            });
                            // ignore: await_only_futures
                            _pickedImage = await _picker.pickImage(
                                source: ImageSource.gallery);
                            _extractText =
                                await FlutterTesseractOcr.extractText(
                                    _pickedImage!.path,
                                    language: lang);
                            setState(() {
                              _scanning = false;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                )),
            SizedBox(height: 20),
            _scanning
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: _pickedImage != null
                              ? _extractText.length == 0
                                  ? Text(
                                      "Loading...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  : SelectableText(
                                      _extractText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    )
                              : Text(
                                  "Scanned text will be displayed here",
                                  style: TextStyle(fontSize: 17),
                                )),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(top: 10,bottom: 30,left: 10,right: 10),
              child: _pickedImage != null && !_scanning
                  ? Container(
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            child: Icon(Icons.copy),
                            onPressed: () {
                                Clipboard.setData(ClipboardData(text: _extractText)).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Text Copied to Clipboard')),
                            );
                            });
                            },
                          ),
                          ElevatedButton(
                            child: Icon(Icons.share),
                            onPressed: () {
                                Share.share(
                                              "$_extractText",
                                              subject: "Share Scanned Text",
                                              
                                            );
                            
                            },
                          ),
                        ],
                      ),
                  )
                  : Row(),
            )
          ],
        ));
  }
}
