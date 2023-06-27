import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadAttachment extends StatelessWidget {
  const UploadAttachment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 250,
        child: InkWell(
          onTap: () {},
          child: Card(
              color: Colors.grey[200],
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_file,
                      size: 100,
                    ),
                    Text(
                      "Upload Your File",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )),
        ));
  }
}
