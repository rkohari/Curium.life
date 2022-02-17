

import 'package:curiumlife/core/model/service/alert_request.dart';
import 'package:curiumlife/core/model/service/alert_response.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/services/dialog_service.dart';
import 'package:curiumlife/ui/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  const DialogManager({ required this.child});

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showInfoDialog, _showCustomAlertDialog, _showConfirmationDialog,_bottomSheet,);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: widget.child
        ),
      ],
    );
  }

  void _showInfoDialog(AlertRequest request) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: request.dismissable,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                _dialogService.dialogComplete(AlertResponse(status: false));
                return false;
              },
              child: CupertinoAlertDialog(
                title: Text(
                  request.title ?? '',
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textOnPrimary,
                      letterSpacing: 0.5
                  ),
                ),
                content: Text(request.description ?? '', style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: AppColor.textOnPrimary,
                    letterSpacing: 0.5
                )),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      request.buttonTitle  ?? '',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primary,
                          letterSpacing: 0.5
                      ),
                    ),
                    onPressed: () {
                      _dialogService.dialogComplete(AlertResponse(status: true));
                    },
                  ),
                ],
              ));
        });
  }

  void _showConfirmationDialog(AlertRequest request) {

    showCupertinoDialog(context: context, builder:  (context) {
      return WillPopScope(
          onWillPop: () async {
            _dialogService.dialogComplete(AlertResponse(status: false));
            return false;
          },
          child: CupertinoAlertDialog(
            title: Text(
              request.title  ?? '',
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textOnPrimary,
                  letterSpacing: 0.5
              ),
            ),
            content: Text(request.description  ?? '', style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: AppColor.textOnPrimary,
                letterSpacing: 0.5
            )),
            actions: <Widget>[

              if (request.secondaryButtonTitle != null) CupertinoDialogAction(
                child: Text(
                  request.secondaryButtonTitle  ?? '',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: AppColor.primary,
                      letterSpacing: 0.5
                  ),
                ),
                onPressed: () {
                  _dialogService.dialogComplete(AlertResponse(status: false));
                },
              ),

              CupertinoDialogAction(
                child: Text(
                  request.buttonTitle  ?? '',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                      letterSpacing: 0.5
                  ),
                ),
                onPressed: () {
                  _dialogService.dialogComplete(AlertResponse(status: true));
                },
              ),

            ],
          ));
    });

  }

  void _showCustomAlertDialog(AlertRequest request) {
    showDialog(context: context,
        builder: (context){
          return WillPopScope(
            onWillPop: (){
              return Future.value(false);
            },
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(20),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24.0))),
              content: Container(
                height: 340,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(Images.appLogo, width: 100, height: 100,),

                    VerticalSpacing.custom(value: 30),

                    Text(request.title  ?? '', textScaleFactor: 1, style: AppTextStyle.headLine2,),

                    VerticalSpacing.d20px(),

                    Text(request.description  ?? '', textAlign: TextAlign.center, textScaleFactor: 1, style: AppTextStyle.button,),

                    VerticalSpacing.d20px(),

                    Button(request.buttonTitle ?? '', width: double.infinity, key: const Key('btnPrimary'), onPressed: (){
                      _dialogService.dialogComplete(AlertResponse(status: true));
                    }),

                    request.secondaryButtonTitle != null ? MaterialButton(onPressed: (){
                      _dialogService.dialogComplete(AlertResponse(status: false));
                    }, child: Text(request.secondaryButtonTitle ?? '', textScaleFactor: 1, style: AppTextStyle.button.copyWith(color: AppColor.primary),)) : Container()

                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  void _bottomSheet(AlertRequest request) {

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        //barrierColor: AppColor.primary,
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        builder: (context) => Container(
          padding: MediaQuery.of(context).viewInsets,
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.bottom > 0 ? MediaQuery.of(context).viewPadding.bottom : 25),
          decoration: const BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:  Radius.circular(15)),
          ),
          child: Wrap(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 4.0,
                  width: 24.0,
                  margin: const EdgeInsets.only(top: 8.0),
                  decoration: const BoxDecoration(
                    color: AppColor.textOnBackground,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
              ),

              if (request.showActionBar == true)
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      if (request.iconWidget != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: request.iconWidget,
                        ),

                      Expanded(
                          child: request.title == null ? Container() : Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(request.title ?? '', textScaleFactor: 1,
                              style: AppTextStyle.button.copyWith(fontSize: 17,),
                            ),
                          )
                      ),

                      if(request.showCloseIcon == true)   IconButton(
                        onPressed: () {
                          _dialogService.dialogComplete(AlertResponse(status: false));
                        },
                        icon: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black12,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.close, size: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              SingleChildScrollView(
                  child: Wrap(
                    children: [
                      SafeArea(child: request.contentWidget ?? Container()),
                    ],
                  )
              ),

            ],
          ),
        )
    );

  }

}