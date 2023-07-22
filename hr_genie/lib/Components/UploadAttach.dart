import 'package:flutter/material.dart';
import 'package:hr_genie/Constants/Color.dart';

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
          child: const Card(
            color: unselectedButtonColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload,
                    size: 50,
                    color: globalTextColor,
                  ),
                  Text(
                    "Upload Your File",
                    style: TextStyle(color: globalTextColor, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
