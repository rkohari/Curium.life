import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/fontsize.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';


Color _focusBgColor = Color(0xffF8F9FF);
Color _errorBgColor = Color(0xffFFF5F5);
Color _errorColor = Color(0xffEB1414);

TextStyle _errorTextStyle = TextStyle(fontSize: AppFontSize.dp12, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0.5, color: _errorColor);
TextStyle _labelTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20 / 14, letterSpacing: 0.5, color: AppColor.textOnBackground);
TextStyle _disableLabelTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 20 / 14, letterSpacing: 0.5, color: AppColor.textOnBackground.withOpacity(0.50));
TextStyle _bodyTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 24 / 16, letterSpacing: 0.15, color: AppColor.textOnBackground);
TextStyle _disableBodyTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 24 / 16, letterSpacing: 0.15, color: AppColor.textOnBackground.withOpacity(0.50));
TextStyle _hintTextStyle = AppTextStyle.bodyText1.copyWith(color : Color(0xffbdc1c6));
TextStyle _optionalTextStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 18 / 12, letterSpacing: 0.5, color: AppColor.textOnBackground.withOpacity(0.60));

BorderRadius _borderRadius = BorderRadius.circular(4);




class EditTextField extends StatefulWidget {

  FormFieldController controller;

  String? label;
  TextStyle? textStyle;
  TextStyle? labelTextStyle;
  TextAlign? textAlign;
  double? height;
  String? subTitle;


  EdgeInsets? margin;
  EdgeInsets? padding;

  TextInputAction? textInputAction;

  String? placeholder;
  Widget? prefixIcon;
  Widget? suffixIcon;

  String? prefixText;
  String? suffixText;
  String? counterText;

  bool autoFocus = false;
  bool isPasswordField = false;
  bool isDecoration = false;
  bool withSuggestion = false;
  bool showRequiredHint = true;

  bool enabled = true;


  ValueChanged<String>? onChanged = (terms) {};
  ValueChanged<String>? onSubmitted = (terms) {};

  EditTextField(this.label,
      this.controller,
      {this.margin = EdgeInsets.zero,
        required this.onSubmitted,
        required this.onChanged,
        this.autoFocus = false,
        this.enabled = true,
        this.prefixText,
        this.height,
        this.suffixText,
        this.placeholder,
        this.padding,
        this.prefixIcon,
        this.textAlign = TextAlign.left,
        this.textStyle,
        this.labelTextStyle,
        this.showRequiredHint = true,
        this.textInputAction = TextInputAction.next,
        this.suffixIcon,
        this.counterText
      });

  EditTextField.noDecoration(this.label,
      this.controller,
      {this.margin = EdgeInsets.zero,
        this.onSubmitted,
        this.onChanged,
        this.autoFocus = false,
        this.enabled = true,
        this.prefixText,
        this.height,
        this.suffixText,
        this.placeholder,
        this.padding,
        this.prefixIcon,
        this.textAlign = TextAlign.left,
        this.textStyle,
        this.labelTextStyle,
        this.showRequiredHint = true,
        this.textInputAction = TextInputAction.next,
        this.suffixIcon,
        this.counterText
      }){
    isDecoration = true;
  }

  EditTextField.password(this.label,
      this.controller,
      { this.margin = EdgeInsets.zero,
          this.onSubmitted,
          this.onChanged,
          this.enabled = true,
          this.autoFocus = false,
          this.prefixText,
          this.placeholder,
          this.prefixIcon,
          this.padding,
          this.showRequiredHint = true,
          this.textAlign = TextAlign.left,
        this.height,
          this.textInputAction = TextInputAction.next,
          this.suffixIcon }) {
    isPasswordField = true;
  }



  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {

  bool isVisible = false;



  @override
  Widget build(BuildContext context) {

    return new Container(
      margin: widget.margin,
      child: FormField<String>(
        initialValue: widget.controller.text,
        validator: (value) {

          if (!widget.controller.required && widget.controller.text.isEmpty) {
            return null;
          }

          if ((widget.controller.required || widget.controller.text.isNotEmpty) && widget.controller.validator != null) {
            return widget.controller.validator!(value);
          }

          return null;
        },
        builder: (FormFieldState state) {
          if (widget.controller.textEditingController.hasListeners) {
            widget.controller.textEditingController.removeListener(() { });
          }

          widget.controller.textEditingController.addListener(() {
            state.reset();
            state.didChange(widget.controller.text);
          });

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                widget.label!.isNotEmpty ? Padding(
                  padding:EdgeInsets.only(left: 4.0),
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                          widget.label!,
                          style: widget.enabled ? _labelTextStyle: widget.labelTextStyle != null ? widget.labelTextStyle : _disableLabelTextStyle ,
                        ),
                      ),

                     if (!widget.controller.required)
                        Text(
                          "Optional",
                          style: _optionalTextStyle,
                        )

                    ],
                  ),
                ) : Container(),

                widget.label!.isNotEmpty ? Padding(
                  padding: EdgeInsets.only(top: 6),
                ) : Container(),

               // widget.type == EditTextFieldType.normal ?
          SizedBox(
                  height: widget.controller.minLines > 1
                      ? null
                      : widget.height == null
                          ? 40
                          : widget.height,
                  child:  TextField(
                      key: widget.controller.fieldKey,
                      controller: widget.controller.textEditingController,
                      enableInteractiveSelection: true,
                      obscureText:widget.isPasswordField && !isVisible ? true : false,
                      textInputAction: widget.textInputAction,
                      textAlign: widget.textAlign!,
                      style: widget.enabled? _bodyTextStyle : widget.textStyle ?? _disableBodyTextStyle,
                      focusNode: widget.controller.focusNode,
                      autofocus: widget.autoFocus,
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        if (widget.onChanged != null) {
                          widget.onChanged!(value);
                        }
                      },
                      onSubmitted: (value) {
                        if (widget.onSubmitted != null) {
                          widget.onSubmitted!(value);
                        }
                      },
                      enabled: widget.enabled,
                      maxLength: widget.controller.maxLength,
                      maxLines: widget.isPasswordField? 1
                          : widget.controller.maxLines,
                      minLines: widget.controller.minLines,
                      inputFormatters: widget.isPasswordField ||widget.controller.textInputType ==TextInputType.emailAddress? [FilteringTextInputFormatter.deny(new RegExp('[\\ ]')),]: widget.controller.inputFormatter,
                      decoration: InputDecoration(
                        fillColor:state.hasError ? _errorBgColor : _focusBgColor,
                        filled: true,
                        contentPadding: widget.padding ??EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        border: _outlineInputBorder(state.hasError),
                        enabledBorder: _outlineInputBorder(state.hasError),
                        disabledBorder: _outlineInputBorder(state.hasError),
                        focusedBorder: _focusedInputBorder,
                        errorBorder: _errorInputBorder,
                        errorStyle: _errorTextStyle,
                        hintText: widget.placeholder,
                        hintStyle: _hintTextStyle,
                        focusColor: _focusBgColor,
                        suffixIconConstraints:
                            BoxConstraints(minWidth: 15, maxHeight: 20),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 15, maxHeight: 20),
                        suffix: widget.suffixText == null
                            ? null
                            : Text(
                                "${widget.suffixText}",
                                style: _bodyTextStyle,
                              ),
                        prefix: widget.prefixText == null
                            ? null
                            : Text(
                                "${widget.prefixText} ",
                                style: _bodyTextStyle,
                              ),
                        prefixIcon: widget.prefixIcon == null
                            ? null
                            : widget.prefixIcon,
                        suffixIcon: widget.isPasswordField
                            ? _buildPasswordEyeIcon()
                            : widget.suffixIcon != null
                                ? widget.suffixIcon
                                : null,
                        counterText: widget.counterText != null
                            ? widget.counterText
                            : "",
                      ),
                      keyboardType: widget.controller.textInputType,
                      textCapitalization: widget.controller.textCapitalization),
                ) ,

              //: _autocomplete(state),

                if (state.hasError && widget.showRequiredHint)
                  Text(state.errorText!, style: _errorTextStyle,)
          ]
          );
        },
      ),
    );

  }






  Widget _buildPasswordEyeIcon(){
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.only(right: 10, ),
          child: Icon(isVisible ? Icons.visibility_off : Icons.visibility, color: Colors.black,)),
      onTap: () {
        isVisible = !isVisible;
        setState(() {});
      }
    );
  }
  InputBorder _outlineInputBorder(bool hasError) => OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: BorderSide(color: hasError ? _errorColor : Color.fromRGBO(0, 0, 0, 0.08), width: 1.2),
  );

  InputBorder _focusedInputBorder = OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: BorderSide(color: AppColor.textOnBackground, width: 1.2),
  );

  InputBorder _errorInputBorder = OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: BorderSide(color:Color(0xffEB1414), width: 1.2),
  );

}


