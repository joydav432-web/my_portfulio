import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _accentColor = Color(0xFFE84C3D);
const _greyText = Color(0xFF9CA3AF);
const _borderColor = Colors.white12;
const _onlineGreen = Color(0xFF22C55E);

class MobileFooter extends StatelessWidget {
  const MobileFooter({
    super.key,
    this.onNavTap,
    this.email = 'joydav432@gmail.com',
    this.githubUrl = 'https://github.com/joydav432-web',
    this.linkedinUrl = 'https://www.linkedin.com/in/joy-deb-2a8b41407/',
    this.resumeUrl = '',
  });

  final void Function(String label)? onNavTap;
  final String email;
  final String githubUrl;
  final String linkedinUrl;
  final String resumeUrl;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 700;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrandSection(),
          const SizedBox(height: 32),
          if (isCompact)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNavColumn(context),
                const SizedBox(height: 20),
                _buildContactColumn(context),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildNavColumn(context)),
                const SizedBox(width: 20),
                Expanded(child: _buildContactColumn(context)),
              ],
            ),
          const SizedBox(height: 32),
          Container(height: 1, color: _borderColor),
          const SizedBox(height: 20),
          const Text(
            '© 2026 Joydav Kumer',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _greyText,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'All rights reserved.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _greyText,
            ),
          ),
          const SizedBox(height: 16),
          _TapText(
            text: 'RESUME',
            onTap: resumeUrl.isEmpty ? null : () => _launch(resumeUrl),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.2),
              ),
              child: const Text(
                'J',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              '.',
              style: TextStyle(
                color: _accentColor,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
            const SizedBox(width: 6),
            const Expanded(
              child: Text(
                'Joydav Kumer',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Flutter App Developer building high-performance, cross-platform '
              'mobile applications with REST API integration and modern UI/UX.',
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: _greyText,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: _onlineGreen,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Open to freelance & full-time roles',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _onlineGreen,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavColumn(BuildContext context) {
    const items = ['Home', 'About', 'Projects', 'Contact'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Navigation',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            letterSpacing: 1.5,
            color: _greyText,
          ),
        ),
        const SizedBox(height: 14),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _TapText(
              text: item,
              fontSize: 13,
              onTap: () => _handleNavTap(context, item),
            ),
          ),
      ],
    );
  }

  Widget _buildContactColumn(BuildContext context) {
    final items = [
      (Icons.mail_outline, 'Email', 'mailto:$email'),
      (Icons.code, 'GitHub', githubUrl),
      (Icons.business_center_outlined, 'LinkedIn', linkedinUrl),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            letterSpacing: 1.5,
            color: _greyText,
          ),
        ),
        const SizedBox(height: 14),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _TapContactItem(
              icon: item.$1,
              label: item.$2,
              onTap: () => _launch(item.$3),
            ),
          ),
      ],
    );
  }

  void _handleNavTap(BuildContext context, String label) {
    if (onNavTap != null) {
      onNavTap!(label);
      return;
    }

    switch (label.toLowerCase()) {
      case 'home':
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        break;
      case 'about':
        Navigator.pushNamedAndRemoveUntil(context, '/about', (route) => false);
        break;
      case 'projects':
        Navigator.pushNamedAndRemoveUntil(context, '/projects', (route) => false);
        break;
      case 'contact':
        Navigator.pushNamedAndRemoveUntil(context, '/contact', (route) => false);
        break;
    }
  }
}


class _TapText extends StatefulWidget {
  const _TapText({required this.text, this.onTap, this.fontSize = 14});

  final String text;
  final VoidCallback? onTap;
  final double fontSize;

  @override
  State<_TapText> createState() => _TapTextState();
}

class _TapTextState extends State<_TapText> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap == null ? null : (_) => setState(() => _pressed = true),
      onTapUp: widget.onTap == null ? null : (_) => setState(() => _pressed = false),
      onTapCancel: widget.onTap == null ? null : () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontFamily: widget.text == 'RESUME' ? 'monospace' : null,
            fontSize: widget.fontSize,
            letterSpacing: widget.text == 'RESUME' ? 2 : 0,
            fontWeight: FontWeight.w600,
            color: _pressed ? _accentColor : Colors.white,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class _TapContactItem extends StatefulWidget {
  const _TapContactItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  State<_TapContactItem> createState() => _TapContactItemState();
}

class _TapContactItemState extends State<_TapContactItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 14,
              color: _pressed ? _accentColor : _greyText,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _pressed ? _accentColor : Colors.white,
                ),
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}