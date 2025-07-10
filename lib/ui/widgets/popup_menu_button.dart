import 'dart:io';
import 'package:retrostore/providers/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPopupMenuButton extends StatefulWidget {
  const MyPopupMenuButton({super.key});

  @override
  State<MyPopupMenuButton> createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameClass>(
      builder: (BuildContext context, myProvider, Widget? child) =>
          PopupMenuButton(
        color: myProvider.isDark ? Colors.blue[200] : null,
        itemBuilder: ((context) => [
              PopupMenuItem(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Text('Buka menu'),
              ),
              const PopupMenuItem(
                child: Text('Tentang'),
              ),
              PopupMenuItem(
                onTap: () => exit(0),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.exit_to_app_outlined,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text('Exit'),
                      ],
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}