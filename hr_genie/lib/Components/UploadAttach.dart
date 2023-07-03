import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadAttachment extends StatefulWidget {
  const UploadAttachment({
    super.key,
  });

  @override
  State<UploadAttachment> createState() => _UploadAttachmentState();
}

class _UploadAttachmentState extends State<UploadAttachment> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 150,
        child: InkWell(
          onTap: () async {},
          child: Card(
            color: Colors.grey[200],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload,
                    size: 50,
                  ),
                  Text(
                    "Upload Your File",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
