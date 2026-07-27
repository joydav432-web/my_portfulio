import 'package:flutter/material.dart';

// ---------- Theme colors ----------
const _accentColor = Color(0xFFE84C3D);
const _greyText = Color(0xFF9CA3AF);
const _borderColor = Colors.white12;
const _fieldFill = Color(0xFF141414);
const _whatsappGreen = Color(0xFF25D366);

class MobileContact extends StatefulWidget {
  const MobileContact({super.key});

  @override
  State<MobileContact> createState() => _MobileContactState();
}

class _MobileContactState extends State<MobileContact> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('CONTACT'),
          const SizedBox(height: 14),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 36,
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
          const SizedBox(height: 16),
          const Text(
            "Available for Dynamic Flutter App Development, REST API Integration, and Contract Projects. Usually responds within 1–2 hours.",
            style: TextStyle(
              fontSize: 14,
              color: _greyText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          _infoTile(
            icon: Icons.mail_outline,
            label: 'Email',
            value: 'joydav432@gamil.com',
          ),
          _divider(),
          _infoTile(
            icon: Icons.chat_bubble_outline,
            label: 'Whatsapp',
            value: '+880 1793787087',
          ),
          _divider(),
          _infoTile(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Dhaka, Bangladesh',
          ),
          const SizedBox(height: 36),
          _buildFormCard(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
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

  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _accentColor, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    letterSpacing: 2,
                    color: _greyText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(height: 1, color: _borderColor);
  }

  Widget _buildFormCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xff131312),
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send a message',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "I'll get back to you within 1-2 hours.",
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _greyText,
                ),
              ),
              const SizedBox(height: 22),
              _buildField(
                label: 'NAME',
                icon: Icons.person_outline,
                controller: _nameController,
                hint: 'John Doe',
              ),
              const SizedBox(height: 16),
              _buildField(
                label: 'EMAIL',
                icon: Icons.mail_outline,
                controller: _emailController,
                hint: 'john@example.com',
              ),
              const SizedBox(height: 16),
              _buildDropdownField(),
              const SizedBox(height: 16),
              _buildField(
                label: 'MESSAGE',
                icon: Icons.chat_bubble_outline,
                controller: _messageController,
                hint: 'Tell me about your project...',
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: submit logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SEND MESSAGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'monospace',
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ---------- Floating WhatsApp button ----------
      ],
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
            Icon(icon, size: 12, color: _greyText),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
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
            hintStyle: TextStyle(color: _greyText.withOpacity(0.6)),
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
            const Icon(Icons.list_alt_outlined, size: 12, color: _greyText),
            const SizedBox(width: 6),
            const Text(
              'INQUIRY TYPE',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
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