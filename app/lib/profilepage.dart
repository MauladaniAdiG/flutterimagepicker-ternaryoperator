import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile pickedFile;
  List<PickedFile> pickedFileList = [];
  dynamic pickError;

  Future<void> getImageFromCamera() async {
    try {
      final getImageFile =
          await _imagePicker.getImage(source: ImageSource.camera);
      setState(() {
        pickedFile = getImageFile;
        pickedFileList.add(pickedFile);
      });
    } catch (value) {
      setState(() {
        pickError = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () {
            getImageFromCamera();
          },
        ),
        appBar: PreferredSize(
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            preferredSize: Size.fromHeight(0)),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerProfile(),
              SizedBox(
                height: 15,
              ),
              profileName(),
              SizedBox(
                height: 15,
              ),
              tabBar(),
              pickedFileList.isNotEmpty ? gridViewUi() : cameraFile()
            ],
          ),
        ));
  }

  Widget headerProfile() {
    return Container(
        child: Row(
      children: [
        Expanded(
          child: Container(
              height: 120,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://pbs.twimg.com/profile_images/1080708776364171265/RmjxdneU_400x400.jpg')))),
        ),
        Expanded(
          flex: 2,
          child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text('300k'),
                            Text('Posts'),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text('400k'),
                            Text('Followers'),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text('300k'),
                            Text('Following'),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('Edit Profile'),
                    ),
                  )
                ],
              )),
        )
      ],
    ));
  }

  Widget profileName() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Name'), Text('Deskripsi')],
      ),
    );
  }

  Widget tabBar() {
    return Container(
      height: 35,
      color: Color(0xFFdae3f2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.grid_on_rounded),
          Icon(Icons.camera_alt),
          Icon(Icons.grid_off),
        ],
      ),
    );
  }

  Widget cameraFile() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      alignment: Alignment.center,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.lightGreen),
      child: IconButton(
          splashColor: Colors.blue,
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            getImageFromCamera();
          }),
    );
  }

  Widget gridViewUi() {
    return Container(
      height: 220,
      child: GridView.builder(
          itemCount: pickedFileList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.90, crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            return Container(
              child: Image.file(File(pickedFileList[index].path)),
            );
          }),
    );
  }
}
