import 'package:image_picker/image_picker.dart';
import 'package:imapp/http/request.dart';
import 'dart:io';

import 'package:dio/dio.dart';

class UploadModel {
  Request http = Request();
  Future imageUpload(File file) async {
    print('object');
    FormData formData =
        FormData.fromMap({"images": await MultipartFile.fromFile(file.path)});
    print(formData);
    return http.post('/upload/image', params: {"file": formData});
  }
}
