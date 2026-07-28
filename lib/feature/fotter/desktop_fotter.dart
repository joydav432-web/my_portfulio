import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _accentColor = Color(0xFFE84C3D);
const _greyText = Color(0xFF9CA3AF);
const _borderColor = Colors.white12;
const _onlineGreen = Color(0xFF22C55E);

class DesktopFooter extends StatelessWidget {
  const DesktopFooter({
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
    final isCompact = MediaQuery.of(context).size.width < 900;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff131312),
        border: Border.all(color: _borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(isCompact ? 24 : 80, 40, isCompact ? 24 : 80, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCompact)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrandSection(),
                const SizedBox(height: 24),
                _buildNavColumn(context),
                const SizedBox(height: 20),
                _buildContactColumn(context),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _buildBrandSection()),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: _buildNavColumn(context)),
                const SizedBox(width: 60),
                Expanded(flex: 3, child: _buildContactColumn(context)),
              ],
            ),
          const SizedBox(height: 40),
          Container(height: 1, color: _borderColor),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '© 2026 Joydav Kumer — All rights reserved.',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _greyText,
                ),
              ),
              _HoverText(
                text: 'RESUME',
                onTap: resumeUrl.isEmpty ? null : () => _launch(resumeUrl),
              ),
            ],
          ),
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
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.4),
              ),
              child: const Text(
                'J',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              '.',
              style: TextStyle(
                color: _accentColor,
                fontWeight: FontWeight.w900,
                fontSize: 26,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Joydav Kumer',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Flutter App Developer building high-performance, cross-platform '
              'mobile applications with REST API integration and modern UI/UX.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: _greyText,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: _onlineGreen,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Open to freelance & full-time roles',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _onlineGreen,
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
            fontSize: 12,
            letterSpacing: 1.5,
            color: _greyText,
          ),
        ),
        const SizedBox(height: 18),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _HoverText(
              text: item,
              onTap: () => _handleNavTap(context, item),
            ),
          ),
      ],
    );
  }

  Widget _buildContactColumn(BuildContext context) {
    final items = [
      (Icons.mail_outline, email, 'mailto:$email'),
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
            fontSize: 12,
            letterSpacing: 1.5,
            color: _greyText,
          ),
        ),
        const SizedBox(height: 18),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _HoverContactItem(
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
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 'about':
        Navigator.pushReplacementNamed(context, '/about');
        break;
      case 'projects':
        Navigator.pushReplacementNamed(context, '/projects');
        break;
      case 'contact':
        Navigator.pushReplacementNamed(context, '/contact');
        break;
    }
  }
}

class _HoverText extends StatefulWidget {
  const _HoverText({required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  State<_HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<_HoverText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          offset: _hovering ? const Offset(0.08, 0) : Offset.zero,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontFamily: widget.text == 'RESUME' ? 'monospace' : null,
              fontSize: 14,
              letterSpacing: widget.text == 'RESUME' ? 2 : 0,
              fontWeight: FontWeight.w600,
              color: _hovering ? _accentColor : Colors.white,
            ),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}

class _HoverContactItem extends StatefulWidget {
  const _HoverContactItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  State<_HoverContactItem> createState() => _HoverContactItemState();
}

class _HoverContactItemState extends State<_HoverContactItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          offset: _hovering ? const Offset(0.06, 0) : Offset.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 15,
                color: _hovering ? _accentColor : _greyText,
              ),
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _hovering ? _accentColor : Colors.white,
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}