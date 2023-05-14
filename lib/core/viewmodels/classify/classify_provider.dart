import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:vitaflow/core/utils/navigation/navigation_utils.dart';

/// State list
enum ClassifyState { Idle, Scanning, Complete }

class ClassifyProvider extends ChangeNotifier {
  /// ----------------------------
  /// This is side for property data
  /// ----------------------------

  /// Handle scanning state
  ClassifyState _scanState = ClassifyState.Idle;
  ClassifyState get scanState => _scanState;

  /// Cake result
  String? _productResult;
  String? get productResult => _productResult;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String modelAsset = "assets/models";
  String modelPath = "assets/models/model_unquant.tflite";
  String labelPath = "assets/models/labels.txt";

  static ClassifyProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  /// ----------------------------
  /// This is side for function logic
  /// ----------------------------
  /// Scanning image using tensorflow
  /// based on the trained model
  Future<void> scan(BuildContext context, File image) async {
    /// Set scan state to scanning
    setScanState(ClassifyState.Scanning);

    /// Waiting 2 second to show
    /// detectif image
    await Future.delayed(Duration(seconds: 2));

    /// Classify an image
    await classify(image);

    setScanState(ClassifyState.Complete);
    notifyListeners();
  }

  /// Classify image using tensorflow
  Future<void> classify(File image) async {
    /// Load models
    ///
    await Tflite.loadModel(model: modelPath, labels: labelPath);

    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    /// We must validate confidence rate to above 0.98
    /// to make sure the result is correct
    print(output ); 
    if (output!.length > 0 &&
        double.parse(output[0]['confidence'].toString()) > 0.99) {
      _productResult = output[0]["label"].toString();
      _errorMessage = null;
      print("in provider");
      print(_productResult);
      print("=====");
    } else {
      print('ok');
      _errorMessage = 'Upss sepertinya product yang di input tidak tersedia';
      _productResult = null;
    }

    notifyListeners();
  }

  /// Set event state
  void setScanState(ClassifyState value) {
    _scanState = value;
    notifyListeners();
  }

  void clearResult() {
    _scanState = ClassifyState.Idle;
    _productResult = null;
    notifyListeners();
  }
}
