import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../popupbutton.dart';
import '../widgets/common_buttons.dart';
import '../constants.dart';
import 'select_photo_options_screen.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SetPhotoScreen extends StatefulWidget {
  const SetPhotoScreen({super.key});
  @override
  State<SetPhotoScreen> createState() => _SetPhotoScreenState();
}

class _SetPhotoScreenState extends State<SetPhotoScreen> {
  String mainurl = "http://e-gam.com/img/GKAPROFILE";
  File? _image;

  bool _vb1 = false;
  bool isLoading = false;

  String? _Name;

  bool _imgavl = false;
  String _imgupload1 = "";
  int _id = 0;

  void sharedprefget() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _Name = prefs.getString("Name");
      _imgavl = prefs.getBool("imgavl")!;
      _imgupload1 = prefs.getString("imgupload1")!;
      _id = prefs.getInt("id")!;

      onloadimgget();
    });
  }

  @override
  void initState() {
    sharedprefget();
    super.initState();
  }

  void onloadimgget() async {
    Directory? directory;
    try {
      if (_imgavl == true) {
        if(Platform.isIOS){
         directory=await getApplicationDocumentsDirectory();
        }else{
          directory = await getExternalStorageDirectory();
        }

        String dirPath =
            '${directory?.path}/gkaimg/$_id/1';

        String filePath = '$dirPath/$_imgupload1';
        File f1 = File(filePath);
        if (await f1.exists()) {
          setState(() {
            _image = f1;
          });
        } else {
          saveNetworkImage("$mainurl/$_id", _imgupload1);
        }
      } else {
        File f = await getImageFileFromAssets('images/nopic.png');
        setState(() {
          _image = f;
        });
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  Future<void> saveNetworkImage(String imageUrl, String filename) async {
    Directory? directory;
    try {
      if(Platform.isIOS){
        directory = await getApplicationDocumentsDirectory();
      }else{
        directory = await getExternalStorageDirectory();
      }

      String dirPath =
          '${directory?.path}/gkaimg/$_id/1'; // Change 'my_images' to your desired folder name
      await Directory(dirPath).create(recursive: true);
      String filePath = '$dirPath/$filename';
      var response = await http.get(Uri.parse('$imageUrl/$filename'));
      if (response.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _image = file;
        });
        print('Image saved to: $filePath');
      } else {
        _imgavl=false;
        print('Failed to download the image');
      }
    } catch (e) {
      _imgavl=false;
      print('Error saving image: $e');
    }
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        _vb1 = true;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future uploadImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? _id = prefs.getInt("id");
    final uri = Uri.parse("http://e-gam.com/GKARESTAPI/image1?User_Id=$_id");
    var request = http.MultipartRequest("POST", uri);
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var res = await request.send();
    final responseData = await res.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    if (res.statusCode == 200) {
      var str = json.decode(responseString);
      bool res = str['result'];
      if (res == true) {
        setState(() {
          _imgavl = true;
        prefs.setBool("imgavl", _imgavl);
          _imgupload1 = str["imgupload1"];
         prefs.setString("imgupload1", _imgupload1);

          _vb1 = false;
          saveNetworkImage("$mainurl/$_id", _imgupload1);
          isLoading = false;
        });
        sucesspopup(context, "Image Successfully Uploaded");

      } else {
        setState(() {
          _imgavl=false;
          prefs.setBool("imgavl", _imgavl);
          _imgupload1 = str["imgupload1"];
          prefs.setString("imgupload1", _imgupload1);

        });
        errorpopup(context, "Something Wrong Please try Again");
      }
    } else {
      errorpopup(context, "Error Please Try Again");

      setState(() {
        _imgavl=false;
        prefs.setBool("imgavl", _imgavl);
        _imgupload1 = "";
        prefs.setString("imgupload1", _imgupload1);

      });

    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;

    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Set a photo of yourself-\n${_Name}',
                          style: txtfntsize,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Photos make your profile more engaging',
                          style: txtfntsize1,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
                      child: Center(
                        child: Container(
                            height: 400.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child:_image ==null ? null : CircleAvatar(
                                backgroundImage: FileImage(_image!),
                                radius: 200.0,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CommonButtons(
                      onTap: () => _showSelectPhotoOptions(context),
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      textLabel: 'Add a Photo',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: _vb1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          uploadImage();
                        },
                        child: isLoading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Loading...',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            : const Text(
                                'Upload Photo',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
