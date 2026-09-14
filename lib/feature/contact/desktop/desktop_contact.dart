import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _accentColor = Color(0xFFE84C3D);
const _greyText = Color(0xFF9CA3AF);
const _borderColor = Colors.white12;
const _fieldFill = Color(0xFF141414);

class DesktopContact extends StatefulWidget {
  const DesktopContact({super.key});

  @override
  State<DesktopContact> createState() => _DesktopContactState();
}

class _DesktopContactState extends State<DesktopContact> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _inquiryType = 'Project';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: _buildLeftSide(),
          ),
          const SizedBox(width: 60),
          Expanded(
            flex: 6,
            child: _buildFormCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('CONTACT'),
        const SizedBox(height: 16),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w800,
              height: 1.05,
              color: Colors.white,
            ),
            children: [
              TextSpan(text: "Let's Work\n"),
              TextSpan(text: "Together", style: TextStyle(color: _accentColor)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Available for Dynamic Flutter App Development, REST API Integration, and Contract Projects. Usually responds within 1–2 hours.",
          style: TextStyle(
            fontSize: 15,
            color: _greyText,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 48),
        _HoverInfoTile(
          icon: Icons.mail_outline,
          label: 'Email',
          value: 'joydav432@gmail.com',
          onTap: () => _launch('mailto:joydav432@gmail.com'),
        ),
        _divider(),
        _HoverInfoTile(
          icon: Icons.chat_bubble_outline,
          label: 'Whatsapp',
          value: '+880 1793787087',
          onTap: () => _launch('https://wa.me/8801793787087'),
        ),
        _divider(),
        _HoverInfoTile(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: 'Dhaka, Bangladesh',
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            letterSpacing: 3,
            color: _greyText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(height: 1, color: _borderColor),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(height: 1, color: _borderColor);
  }

  Widget _buildFormCard() {
    return _HoverFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send a message',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "I'll get back to you within 1-2 hours.",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: _greyText,
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: _buildField(
                  label: 'NAME',
                  icon: Icons.person_outline,
                  controller: _nameController,
                  hint: 'John Doe',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildField(
                  label: 'EMAIL',
                  icon: Icons.mail_outline,
                  controller: _emailController,
                  hint: 'john@example.com',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDropdownField(),
          const SizedBox(height: 20),
          _buildField(
            label: 'MESSAGE',
            icon: Icons.chat_bubble_outline,
            controller: _messageController,
            hint: 'Tell me about your project...',
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          _AnimatedSendButton(
            onPressed: () {
              final name = _nameController.text.trim();
              final email = _emailController.text.trim();
              final msg = _messageController.text.trim();
              final subject = Uri.encodeComponent('[$_inquiryType] Inquiry from $name');
              final body = Uri.encodeComponent('From: $name ($email)\n\n$msg');
              _launch('mailto:joydav432@gmail.com?subject=$subject&body=$body');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: _greyText),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                letterSpacing: 2,
                color: _greyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: _greyText.withValues(alpha: 0.6)),
            filled: true,
            fillColor: _fieldFill,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: _borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: _borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: _accentColor, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    const options = ['Project', 'Job Opportunity', 'Collaboration', 'General'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.list_alt_outlined, size: 13, color: _greyText),
            const SizedBox(width: 6),
            const Text(
              'INQUIRY TYPE',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                letterSpacing: 2,
                color: _greyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: _fieldFill,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _borderColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _inquiryType,
              isExpanded: true,
              dropdownColor: _fieldFill,
              icon: const Icon(Icons.keyboard_arrow_down, color: _greyText),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              items: options
                  .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _inquiryType = val);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _HoverInfoTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _HoverInfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  State<_HoverInfoTile> createState() => _HoverInfoTileState();
}

class _HoverInfoTileState extends State<_HoverInfoTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(_hovered ? 6 : 0, 0, 0),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: _hovered ? 1.2 : 1.0,
                child: Icon(
                  widget.icon,
                  color: _hovered ? Colors.white : _accentColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      letterSpacing: 2,
                      color: _hovered ? _accentColor : _greyText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _hovered ? _accentColor : Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HoverFormCard extends StatefulWidget {
  final Widget child;

  const _HoverFormCard({required this.child});

  @override
  State<_HoverFormCard> createState() => _HoverFormCardState();
}

class _HoverFormCardState extends State<_HoverFormCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xff131312),
          border: Border.all(
            color: _hovered
                ? _accentColor.withValues(alpha: 0.5)
                : _borderColor,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            if (_hovered)
              BoxShadow(
                color: _accentColor.withValues(alpha: 0.08),
                blurRadius: 24,
                spreadRadius: 2,
              ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

class _AnimatedSendButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AnimatedSendButton({required this.onPressed});

  @override
  State<_AnimatedSendButton> createState() => _AnimatedSendButtonState();
}

class _AnimatedSendButtonState extends State<_AnimatedSendButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFFF62440) : _accentColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: const Color(0xFFF62440).withValues(alpha: 0.45),
                  blurRadius: 16,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SEND MESSAGE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'monospace',
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(_hovered ? 4 : 0, 0, 0),
                child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}