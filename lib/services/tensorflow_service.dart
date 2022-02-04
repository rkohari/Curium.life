import 'dart:io';

import 'package:tflite/tflite.dart';

mixin TensorFlowService
{


  Future<String> getScore(File file)
  async {
    print("getScore method called");
    var preditions = await Tflite.runModelOnImage(
        path: file!.path,
        imageMean: 0.0,
        // defaults to 117.0
        imageStd: 255.0,
        // defaults to 1.0
        numResults: 1,
        // defaults to 5
        threshold: 0.1,
        // defaults to 0.1

        asynch: true);
    return preditions![0]["label"];
  }


}