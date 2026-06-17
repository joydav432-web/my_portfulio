import 'package:flutter/material.dart';
import 'package:my_portfulio/constants/links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import 'customtext_formfield.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  bool containsNumber(String value) {
    return RegExp(r'[0-9]').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Get in Touch",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CustomColor.whitePrimary,
              ),
            ),

            const SizedBox(height: 50),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700, maxHeight: 100),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 600) {
                    return buildNameEmailFileDesktop();
                  }
                  return buildEmailFileMobile();
                },
              ),
            ),

            const SizedBox(height: 15),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: CustomTextFiled(
                controller: messageController,
                hintText: "Your message",
                maxline: 10,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Message cannot be empty";
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 30),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // submit logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Message sent!")),

                      );
                      nameController.clear();
                      emailController.clear();
                      messageController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF62440),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Send",
                    style: TextStyle(color:CustomColor.whiteSecondary,
                  ),
                ),
              ),
            ),
            ),

             SizedBox(height: 15),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: const Divider(),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    openUrl(AccountLinks.github);
                  },
                  child: Image.asset(
                    "assets/images/github.png",
                    width: 28,
                  ),
                ),
                InkWell(
                  onTap: () {
                    openUrl(AccountLinks.linkedin);
                  },
                  child: Image.asset(
                    "assets/images/linkedin.png",
                    width: 28,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Row buildNameEmailFileDesktop() {
    return Row(
      children: [
        Flexible(
          child: CustomTextFiled(
            controller: nameController,
            hintText: 'Your name',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Name cannot be empty";
              }
              if (containsNumber(value)) {
                return "Name cannot contain numbers";
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 15),
        Flexible(
          child: CustomTextFiled(
            controller: emailController,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email cannot be empty";
              }
              if (!value.contains("@")) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  Column buildEmailFileMobile() {
    return Column(
      children: [
        Flexible(
          child: CustomTextFiled(
            controller: nameController,
            hintText: 'Your name',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Name cannot be empty";
              }
              if (containsNumber(value)) {
                return "Name cannot contain numbers";
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 15),
        Flexible(
          child: CustomTextFiled(
            controller: emailController,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email cannot be empty";
              }
              if (!value.contains("@")) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
        )
      ],
    );
  }


  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}