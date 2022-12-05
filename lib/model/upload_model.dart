import 'dart:collection';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:imapp/http/request.dart';
import 'dart:io';

import 'package:dio/dio.dart';

class UploadModel {
  Request http = Request();
  Future imageUpload(File file, int id) async {
    var formData = FormData.fromMap({
      "id": id,
      'files': await MultipartFile.fromFile(file.path, filename: 'image')
    });
    return http.post('/upload/image',
        params: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }
}
