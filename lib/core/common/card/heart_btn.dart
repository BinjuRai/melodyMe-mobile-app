// import 'package:flutter/material.dart';

// class HeartButton extends StatefulWidget {
//   final VoidCallback? onTap;
//   const HeartButton({super.key, this.onTap});

//   @override
//   State<HeartButton> createState() => _HeartButtonState();
// }

// class _HeartButtonState extends State<HeartButton> {
//   bool _hovering = false;
//   bool _liked = false;

//   @override
//   Widget build(BuildContext context) {
//     Color color;

//     if (_liked) {
//       color = Colors.red.shade900; // dark red when liked
//     } else if (_hovering) {
//       color = Colors.red.shade400; // lighter red on hover
//     } else {
//       color = Colors.redAccent; // normal color
//     }

//     return MouseRegion(
//       onEnter: (_) {
//         setState(() {
//           _hovering = true;
//         });
//       },
//       onExit: (_) {
//         setState(() {
//           _hovering = false;
//         });
//       },
//       child: IconButton(
//         icon: Icon(_liked ? Icons.favorite : Icons.favorite_border),
//         color: color,
//         onPressed: () {
//           setState(() {
//             _liked = !_liked;
//           });
//           widget.onTap?.call();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class HeartButton extends StatefulWidget {
  final bool isActive;
  final VoidCallback onTap;

  const HeartButton({super.key, required this.isActive, required this.onTap});

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onDoubleTap: widget.onTap, // double tap also toggles
        child: Icon(
          widget.isActive ? Icons.favorite : Icons.favorite_border,
          color:
              widget.isActive
                  ? Colors.red[800] // dark red when active
                  : (_hovering ? Colors.red[300] : Colors.grey),
          size: 28,
        ),
      ),
    );
  }
}
