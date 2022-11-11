import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool button1, button2;

  static final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    button1 = false;
    button2 = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("File sharing using bluetooth"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: _captureSocialPng,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: button1
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Share Screenshot',
                            style: TextStyle(fontSize: 17),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _captureSocialPng() {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;
    return Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      if (boundary!.debugNeedsPaint) {
        Timer(const Duration(seconds: 1), () => _captureSocialPng());
        return;
      }
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$directory/screenshot.png');
      imagePaths.add(imgFile.path);
      imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(imagePaths,
            subject: 'Share',
            text: 'Check this Out!',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }).catchError((onError) {
        print(onError);
      });
    });
  }
}

class ShareFilePlus extends StatefulWidget {
  const ShareFilePlus({Key? key}) : super(key: key);
  @override
  ShareFilePlusState createState() => ShareFilePlusState();
}

class ShareFilePlusState extends State<ShareFilePlus> {
  String text = '';
  String link = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.green,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Share Plus',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('MAD Practical'),
            backgroundColor: Colors.green,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Text:',
                      hintText: 'Enter anything to share',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      text = value;
                    }),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Subject:',
                      hintText: 'Enter subject to share',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      link = value;
                    }),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        onPressed:
                            text.isEmpty ? null : () => _onShare(context),
                        child: const Text('Share'),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(text,
        subject: link,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
