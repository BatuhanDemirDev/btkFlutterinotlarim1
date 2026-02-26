import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  String deger = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Padding(
    padding: MyPadding.allPadding,
    child: Column(
      children: [
        Padding(
          padding: MyPadding.customPaddingPNG,
          child: Image.asset(
            'assets/yayinci.jpg',
            height: 200,
          ),
        ),
        Padding(
          padding: MyPadding.customPaddingPNG,
          child: CustomTextField(
            labelText: 'Kullanıcı Adı', 
            icon: Icons.account_circle,
            autofocus: true,
            onChanged: (value) {
              setState(() {
                deger = value;
              });
            },
          ),
        ),
        CustomTextField(labelText: 'E-posta',icon: Icons.email),
        CustomTextField(labelText: 'Passworld', icon: Icons.lock_outline),
        Padding(
          padding: MyPadding.customPaddingPNG,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Gönder'),
          ),
        ),
        Text('Değer: $deger'),
      ],
    ),
  ),
);
  }
}
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.icon,
    this.autofocus = false, 
    this.onChanged,
  });

  final String labelText;
  final IconData icon;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      maxLength: 10,
      maxLines: 2,
      cursorColor: Colors.red,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: UtilityColor.primaryColor.withValues(alpha: 0.1),
        prefixIcon: Icon(Icons.account_circle),
        suffix: Icon(Icons.check),
        icon: Icon(icon),
        labelText: labelText,
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}

class UtilityColor {
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.green;
  static const Color redColor = Colors.red;
}

class MyPadding {
  static const EdgeInsets allPadding = EdgeInsets.all(16.0);
  static const EdgeInsets symmetricPadding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets verticalPadding = EdgeInsets.symmetric(vertical: 16.0);
  static const EdgeInsets customPaddingPNG = EdgeInsets.only(top: 48);
}
