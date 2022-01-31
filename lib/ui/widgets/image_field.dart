
import 'dart:convert';
import 'dart:typed_data';

import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/fontsize.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';

Color _focusBgColor = Colors.transparent;
Color _errorColor = Color(0xffEB1414);

TextStyle _errorTextStyle = TextStyle(fontSize: AppFontSize.dp12, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0.5, color: _errorColor);
TextStyle _labelTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20 / 14, letterSpacing: 0.15, color: AppColor.secondary);
TextStyle _bodyTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 20 / 14, letterSpacing: 0.44, color: AppColor.tertiaryContainer);
TextStyle _headerTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w900, height: 20 / 16, letterSpacing: 0.44, color: AppColor.tertiaryContainer);

class ImageField extends StatefulWidget {

  ImageFieldController controller;
  EdgeInsets margin;
  BoxShape shape;

  double height;
  double width;
  String placeholder;
  Function? callBack;

  ImageField(this.controller, { this.margin = EdgeInsets.zero, this.height = 104, this.width = 104, this.placeholder = "" ,  this.callBack,this.shape = BoxShape.rectangle});

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {

  final ImagePicker _picker = ImagePicker();

  final BorderRadius _borderRadius = BorderRadius.circular(4.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: widget.margin,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {

          return Column(
            children: [

              InkWell(
                onTap: () async {
                  ImageSource? imageSource = await showDialog<ImageSource>(context: context, builder: (context) => _PickImageOption());
                  if (imageSource == null) return;

                  PickedFile? image = await _picker.getImage(source: imageSource, imageQuality: 50);
                  if (image == null) return;

                  Uint8List? result = await FlutterImageCompress.compressWithFile(
                    image.path,
                    minWidth: 500,
                    minHeight: 500,
                    quality: 94,
                  );

                  setState(() {
                    widget.controller.setValue(base64Encode(result!));
                  });

                  widget.callBack != null ? widget.callBack!(): null ;

                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:  _borderRadius,
                    border: Border.all(color: state.hasError ? _errorColor : _focusBgColor, width: 2)
                  ),
                  height: widget.height,
                  width: widget.width,
                  child: ClipRRect(
                    borderRadius:   _borderRadius,
                    clipBehavior: Clip.antiAlias,
                    child: widget.controller.value == null ?
                    Image.asset(widget.placeholder,height: widget.height,width: widget.width,fit: BoxFit.cover,) :
                    _ImageView(widget.controller.value!)

                  ),
                ),
              ),

              if (state.hasError)
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(state.errorText!,style: _errorTextStyle,)
                )
            ],
          );
        },
        validator: (value) => widget.controller.validator(widget.controller.value),
        initialValue: widget.controller.value,
      ),
    );
  }

}

class _ImageView extends StatelessWidget {

  final String image;

  _ImageView(this.image);

  @override
  Widget build(BuildContext context) {
    return Image.memory(base64Decode(image),
      width:double.infinity, height:double.infinity, fit: BoxFit.cover,
    );
  }


}

class _PickImageOption extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("Select Option", style: _headerTextStyle,),
      titlePadding: EdgeInsets.only(left: 12, top: 12.0,bottom: 16.0),
      contentPadding: EdgeInsets.zero,
      content: Wrap(
        children: [
          Column(
            children: [

              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  onPressed: (){
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: Row(
                    children: [

                      Image.asset(Images.appLogo),

                      HorizontalSpacing.d10px(),

                      Text("Take Photo", style: _bodyTextStyle,),
                    ],
                  ),
                )
              ),

              VerticalSpacing.custom(value: 12.0),

              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  onPressed: (){
                    Navigator.pop(context, ImageSource.gallery);
                  }, child: Row(
                    children: [

                      Image.asset(Images.appLogo),

                      HorizontalSpacing.d10px(),

                      Text("Choose Photo",  style: _bodyTextStyle,),
                    ],
                  ),
                )
              ),
            ],
          ),
        ],
      ),
      actions: [
        MaterialButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel",style: _labelTextStyle,))
      ],
    );

  }

}