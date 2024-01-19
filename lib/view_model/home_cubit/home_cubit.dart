import 'package:eldeep/model/text_class.dart';
import 'package:eldeep/view_model/home_cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<InputText> inputTextList = [];
  Color color = Colors.black;
  List<String> fontFamilies =
      GoogleFonts.asMap().keys.toList().take(20).toList();
  late String selectedFont = fontFamilies[0];
  int size = 14;
  TextEditingController textController = TextEditingController();

  Widget buildListView(int index) {
    return Column(
      children: [
        Text('${index + 1}'),
        Row(
          children: [
            Text(
              inputTextList[index].text,
              style: GoogleFonts.getFont(
                inputTextList[index].font, // Use the font family dynamically
                textStyle: TextStyle(
                  color: inputTextList[index].color,
                  fontSize: inputTextList[index].size.toDouble(),
                ),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      inputTextList.removeAt(index);
                      emit(DeleteText());
                    },
                    icon: const Icon(Icons.delete_outline)),
              ],
            )
          ],
        ),
      ],
    );
  }

  void pickColor(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('pick your color'),
          content: Column(
            children: [
              ColorPicker(
                pickerColor: color,
                onColorChanged: (color) {
                  this.color = color;
                  emit(UpdateColor());
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('select')),
            ],
          ),
        );
      },
    );
  }

  void increaseSize() {
    size++;
    emit(ChangeSize());
  }

  void decreaseSize() {
    if (size != 0) {
      size--;
      emit(ChangeSize());
    }
  }

  void addText() {
    if (textController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'please enter text first', toastLength: Toast.LENGTH_LONG);
    } else {
      InputText text = InputText(
          text: textController.text,
          font: selectedFont,
          color: color,
          size: size);
      inputTextList.add(text);
      emit(UpdateText());
    }
  }
}
