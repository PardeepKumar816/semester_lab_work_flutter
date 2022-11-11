import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:lab_work/shared_perferences_helper.dart';
import 'package:lab_work/sqfilte_database.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

import 'dart:async';
import 'dart:core';

import 'dart:isolate';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab_work/previous_code.dart';
import 'package:vector_math/vector_math_64.dart' show Matrix4, Vector3;
import 'package:flutter/material.dart';
import 'package:lab_work/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: StudentData2());
  }
}
