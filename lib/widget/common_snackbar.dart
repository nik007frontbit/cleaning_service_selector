import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarRed(String message) {
  _showAnimatedOverlaySnackbar(
    message: message,
    backgroundColor: Colors.red,
    icon: const Icon(Icons.warning, color: Colors.white),
  );
}

void showSnackBarGreen(String message) {
  _showAnimatedOverlaySnackbar(
    message: message,
    backgroundColor: Colors.green,
    icon: const Icon(Icons.check_circle, color: Colors.white),
  );
}

void _showAnimatedOverlaySnackbar({
  required String message,
  required Color backgroundColor,
  required Icon icon,
}) {
  Get.closeCurrentSnackbar();

  final overlay = Overlay.of(Get.overlayContext!);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => _SnackbarAnimatedWidget(
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      onClose: () => entry.remove(),
    ),
  );

  overlay.insert(entry);
}
class _SnackbarAnimatedWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Icon icon;
  final VoidCallback onClose;

  const _SnackbarAnimatedWidget({
    required this.message,
    required this.backgroundColor,
    required this.icon,
    required this.onClose,
  });

  @override
  State<_SnackbarAnimatedWidget> createState() => _SnackbarAnimatedWidgetState();
}

class _SnackbarAnimatedWidgetState extends State<_SnackbarAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3)).then((_) async {
      await _controller.reverse();
      widget.onClose();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  widget.icon,
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
