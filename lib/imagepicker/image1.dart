import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uri_to_file/uri_to_file.dart';
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
  File? _image;
  bool _vb1=false;
  String? _Name;
  int? _id;
  bool isLoading = false;

  String? img1 = "";

  bool cimgpathexists1=false;


@override
  void initState()  {
  getinfo();
    // TODO: implement initState
    super.initState();
  }

  void getinfo()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() async {
    _Name=prefs.getString("Name");
    _id=prefs.getInt("id");

    if(prefs.getBool("cimgpathexists1")==true){
      cimgpathexists1=true;
      img1=prefs.getString("img1");
      File file = await toFile(img1!);
      _image=file;

      if(_image == null){
        print("null hai image");
      }else{
        print("null nahi hai lode");
      }

    }


  });


  }


  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        _vb1=true;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }


  Future uploadImage() async{
    final uri = Uri.parse("http://e-gam.com/GKARESTAPI/image1?User_Id=${_id}");
    var request = http.MultipartRequest("POST",uri);
    var pic = await http.MultipartFile.fromPath("image",_image!.path);
    request.files.add(pic);
    var res = await request.send();
    if(res.statusCode == 200){
      setState(() {
        isLoading=false;
        _vb1=false;
      });
      var snackBar = const SnackBar(content: Text('Successfully Uploaded...'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else{
      var snackBar = const SnackBar(content: Text('Error Please Try Again.....'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      children:  [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Set a photo of yourself-${_Name}',
                          style: txtfntsize,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
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
                              child: _image == null
                                  ? const Text(
                                'No image selected',
                                style: TextStyle(fontSize: 20),
                              )
                                  : CircleAvatar(
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
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black
                        ),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          uploadImage();
                        }, child: isLoading? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                          Text('Loading...', style: TextStyle(fontSize: 20),),
                          SizedBox(width: 10,),
                          CircularProgressIndicator(color: Colors.white,),
                        ],
                      ) : const Text('Upload Photo',style: TextStyle(fontSize: 18),),

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
