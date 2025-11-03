import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../widgets/my_button.dart';

import '../../../../core/values/values.dart';

class EditImage extends StatefulWidget {
  const EditImage({super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  File? _file;
  bool _isImage = false;

  final ButtonStyle btnStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    ),
    textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
  );

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedImage != null) {
        setState(() {
          _file = File(pickedImage.path);
          _isImage = true;
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        withData: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _file = File(result.files.single.path!);
          _isImage = [
            'jpg',
            'jpeg',
            'png',
          ].contains(result.files.single.extension?.toLowerCase());
        });
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }

  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Values.horizontalPadding,
          vertical: 25.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyButton(
              btnType: ButtonType.primary,
              text: context.localization.takeImage,
              icon: Icons.camera_alt,
              onTap: () {
                Navigator.pop(ctx);
                _pickImage();
              },
            ),
            MyButton(
              btnType: ButtonType.primary,
              text: context.localization.pickFile,
              icon: Icons.attach_file,
              onTap: () {
                Navigator.pop(ctx);
                _pickFile();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(200);
    return Center(
      child:
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          InkWell(
            onTap: () => _showPickerOptions(context),
            borderRadius: borderRadius,
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: 100.h,
              height: 100.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                border: Border.all(
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: _file == null
                    ? Text(
                        "A",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontSize: 42.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : _isImage
                    ? Image.file(
                        _file!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Text(
                        "File: .${_file!.path.split('.').last}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
      //     const SizedBox(height: 20),
      //     if (_file != null) Text(_file!.path, textAlign: TextAlign.center),
      //   ],
      // ),
    );
  }
}
