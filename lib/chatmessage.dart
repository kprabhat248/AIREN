import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.text,
    required this.sender,
    this.isImage = false,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    final isUser = sender == "user";
    return Container(
      decoration: BoxDecoration(
        color: isUser
            ? Color.fromARGB(201, 68, 239, 148)
            : Color.fromARGB(255, 119, 203, 236),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUser
              ? const SizedBox()
              : Text(sender)
                  .text
                  .subtitle1(context)
                  .fontFamily(GoogleFonts.openSans().fontFamily!)
                  .make()
                  .box
                  .color(isUser
                      ? Color.fromARGB(255, 243, 183, 86)
                      : Color.fromARGB(255, 171, 217, 92))
                  .p16
                  .rounded
                  .alignCenter
                  .makeCentered(),
          Expanded(
            child: isImage
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      text,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const CircularProgressIndicator.adaptive(),
                    ),
                  )
                : text
                    .trim()
                    .text
                    .bodyText1(context)
                    .fontFamily(GoogleFonts.openSans().fontFamily!)
                    .make()
                    .px8()
                    .py4(),
          ),
          isUser
              ? Text(sender)
                  .text
                  .subtitle1(context)
                  .fontFamily(GoogleFonts.openSans().fontFamily!)
                  .make()
                  .box
                  .color(Color.fromARGB(249, 165, 252, 239))
                  .p16
                  .rounded
                  .alignCenter
                  .makeCentered()
              : const SizedBox(),
        ],
      ),
    );
  }
}
