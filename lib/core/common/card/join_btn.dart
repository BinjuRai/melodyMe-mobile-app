import 'package:flutter/material.dart';

class JoinButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;

  const JoinButton({super.key, this.onPressed, this.label = "Join"});

  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  bool _hovering = false;

  final Color darkBlue = const Color(0xFF222740);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = _hovering
        ? darkBlue.withOpacity(0.8) // lighter on hover
        : darkBlue; // normal color

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // pressed color handled by ElevatedButton automatically
        ),
        onPressed: widget.onPressed,
        icon: const Icon(Icons.play_arrow),
        label: Text(widget.label),
      ),
    );
  }
}
