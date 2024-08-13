import 'package:flutter/material.dart';

class UsernameInput extends StatefulWidget {
  final TextEditingController controller;
  const UsernameInput({super.key, required this.controller});

  @override
  State<UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFirst = true;
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (_isFirst) {
          setState(() {
            _isFirst = false;
          });
        } else {
          setState(() {
            _isValid = widget.controller.text.isNotEmpty;
          });
        }
      } else if (!_focusNode.hasFocus) {
        setState(() {
          _isValid = widget.controller.text.isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Username",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              height: 2.5
            ),
          ),
          TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Enter your username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                    color: Colors.black45,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    style: BorderStyle.solid,
                    width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(22.25),
              suffixIcon: !_isFirst 
                  ? Icon(
                      _isValid ? Icons.check_circle : Icons.error,
                      color: _isValid ? Colors.green : Colors.red,
                    )
                  : null,
            ),
          ),
          if (!_isValid &&
              !_isFirst &&
              !_focusNode.hasFocus &&
              widget.controller.text.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'This field is required',
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}

