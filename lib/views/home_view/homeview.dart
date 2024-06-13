import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _textFocusNode.removeListener(_handleFocusChange);
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  maxLines: 1,
                  maxLength: 100,
                  focusNode: _textFocusNode,
                  decoration: InputDecoration(
                    labelText: "Test",
                    border: InputBorder.none,
                    hintText: 'Enter text here',
                    labelStyle: TextStyle(
                        fontWeight: _textFocusNode.hasFocus ? FontWeight.bold : FontWeight.normal,
                        color: Colors.black,
                        fontSize: 30
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
