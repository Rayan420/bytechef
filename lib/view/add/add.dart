// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/notification.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/global/helper.dart';
import 'package:bytechef/view/add/widget/post_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Add extends StatefulWidget {
  Add({super.key, required this.user});
  final User user;
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _ingredientController = TextEditingController();

  TextEditingController _durationController = TextEditingController();
  File? fileImage;
  File? fileVideo;
  int portion = 1;

  List<String> steps = [];
  bool isPosted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Center(child: const Text('Add Recipe')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                  backgroundColor: tPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  // add new recipe to user
                  final recipe = Recipe(
                    image: await Helper.fileToUint8List(fileImage!),
                    owner: widget.user,
                    video: null,
                    imageUrl: '',
                    videoUrl: '',
                    name: _titleController.text,
                    duration: _durationController.text,
                    serving: portion.toString(),
                    description: _descriptionController.text,
                    ingredients: _ingredientController.text.split('\n'),
                    steps: steps,
                    rating: 0,
                    views: 0,
                  );
                  widget.user.addRecipe(recipe);
                  final notification = UserNotification(
                      title: 'Recipe Approved Alert!',
                      body: 'Your recipe ${recipe.name} has been approved',
                      time: DateTime.now().day.toString() +
                          '/' +
                          DateTime.now().month.toString() +
                          '/' +
                          DateTime.now().year.toString(),
                      isRead: false,
                      recipe: recipe);
                  widget.user.addNotification(notification);
                },
                child: Text(
                  'Post Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Text(
            'Recipe Title',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          PostField(
            controller: _titleController,
            hintText: 'Family Favorite Chicken Soup',
          ),
          SizedBox(height: 10),
          Text(
            'Description',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          PostField(
            controller: _descriptionController,
            hintText: "Example: grandma's delicious recipe...",
          ),
          SizedBox(height: 10),
          Text(
            'Recipe Photo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.48,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: fileImage == null
                ? IconButton(
                    icon: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      //SEND PERMISSION REUQEST

                      Permission.camera.request().then((value) {
                        if (value.isGranted) {
                          _imgFromGallery();
                        } else {
                          showAlertDialog(context);
                        }
                      });
                    },
                  )
                : Image.file(
                    fileImage!,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portions',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 50,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: TextField(
                    onChanged: (value) {
                      portion = int.parse(value);
                    },
                    showCursor: false,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counter: const Offstage(),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.purple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 100,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  controller: _durationController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '00:00',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.purple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          Text(
            'Recipe Video (Optional)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.48,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: fileImage == null
                ? IconButton(
                    icon: Icon(
                      Icons.video_call,
                      size: 40,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      //SEND PERMISSION REUQEST

                      Permission.camera.request().then((value) {
                        if (value.isGranted) {
                          _imgFromGallery();
                        } else {
                          showAlertDialog(context);
                        }
                      });
                    },
                  )
                : Image.file(
                    fileImage!,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 10),
          // ingredients
          Text(
            'Ingredients',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: '1 cup of flour\n1 cup of sugar\n1 cup of milk',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          // steps
          Text(
            'Steps',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return buildStepCard(index);
            },
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.grey, width: 0.5),
                backgroundColor: tPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  steps.add('');
                });
              },
              child: Text('Add Step', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  final picker = ImagePicker();

  _imgFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        fileImage = file;
      });
    }
  }

  _imgFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        fileImage = file;
      });
    }
  }

  void showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow access to gallery and photos'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  Widget buildStepCard(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            steps[index] = value;
          },
          decoration: InputDecoration(
            hintText: 'Step ${index + 1}',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
