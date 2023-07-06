// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class LoadingOverlay {
//   late OverlayEntry? _overlay;

//   void show(BuildContext context) {
//     if (_overlay == null) {
//       _overlay = OverlayEntry(
//         builder: (context) => Container(
//           color: Color(0x80000000),
//           child: Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation(Colors.white),
//             ),
//           ),
//         ),
//       );
//       Overlay.of(context)?.insert(_overlay);
//     }
//   }

//   void hide() {
//     if (_overlay != null) {
//       _overlay.remove();
//       _overlay = null;
//     }
//   }
// }
