import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum SocialType { google, apple, github }

class SocialButton extends StatelessWidget {
  final SocialType type;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        hoverColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
        splashColor: AppColors.primary.withOpacity(0.15),
        child: Container(
          width: 68,
          height: 54,
          decoration: BoxDecoration(
            color: isDark ? AppColors.inputBgDark : AppColors.inputBgLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
              width: 1.2,
            ),
          ),
          child: Center(
            child: _buildIcon(isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(bool isDark) {
    switch (type) {
      case SocialType.google:
        return const _GoogleIcon();
      case SocialType.apple:
        return Icon(
          Icons.apple,
          size: 26,
          color: isDark ? Colors.white : Colors.black,
        );
      case SocialType.github:
        return Icon(
          Icons.code_rounded,
          size: 24,
          color: isDark ? Colors.white : Colors.black87,
        );
    }
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(22, 22),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 3.6;

    final paintRed = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final paintYellow = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final paintGreen = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final paintBlue = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    // Red arc (top)
    canvas.drawArc(rect, -2.4, 1.4, false, paintRed);
    // Yellow arc (left)
    canvas.drawArc(rect, 2.2, 1.3, false, paintYellow);
    // Green arc (bottom)
    canvas.drawArc(rect, 0.6, 1.5, false, paintGreen);
    // Blue arc (right)
    canvas.drawArc(rect, -0.9, 1.4, false, paintBlue);

    // Blue horizontal bar
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(center.dx - 1, center.dy - 1.8, size.width, center.dy + 1.8),
        const Radius.circular(1.8),
      ),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
