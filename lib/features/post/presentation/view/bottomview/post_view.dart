import 'dart:io';

import 'package:bigtalk/features/post/domain/entity/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final TextEditingController _captionController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _post() async {
    final caption = _captionController.text;
    final image = _image; // Assuming you have captured the image file

    if (caption.isNotEmpty && image != null) {
      final post = PostEntity(
        caption: caption,
        image: [image.path],
      );

      // final result = await context.read(postUseCaseProvider).createPost(post);

      // result.fold(
      //   (failure) {
      //     // Handle failure (e.g., show error message)
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text('Failed to create post: ${failure.error}'),
      //     ));
      //   },
      //   (success) {
      //     // Handle success (e.g., show success message)
      //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Text('Post created successfully'),
      //     ));

      //     // Optionally, navigate to another screen or perform additional actions
      //   },
      // );
    } else {
      // Show error message if caption or image is empty
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter caption and select an image'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _post,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: 'Enter caption',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _getImage,
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.withOpacity(0.3),
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Icon(Icons.add_a_photo),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
