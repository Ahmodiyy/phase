import "package:flutter/material.dart";

const Color backgroundColor = Colors.white;
const Color foregroundColor = Colors.black;

const constantInputDecoration = InputDecoration(
  hintText: 'Search',
  fillColor: backgroundColor,
  filled: true,
  suffixIconColor: Colors.black,
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(
        15,
      ),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(
      15,
    )),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(
      15,
    )),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(
      15,
    )),
  ),
);
