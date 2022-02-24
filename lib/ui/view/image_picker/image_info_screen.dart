import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/image_picker/image_picker_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ImageInfoScreen extends ViewModelBuilderWidget<ImagePickerViewModel> {
  var data;

  @override
  void onViewModelReady(ImagePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  ImagePickerViewModel viewModelBuilder(BuildContext context) =>
      ImagePickerViewModel();

  @override
  Widget builder(
      BuildContext context, ImagePickerViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () async {
        await viewModel.storeInsideTheDB(data);
        navigationService.popAllAndPushNamed(Routes.dashboard);

        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
     /*     leading: GestureDetector(
            onTap: () async {
              await viewModel.storeInsideTheDB(data);
              navigationService.popAllAndPushNamed(Routes.dashboard);
            },
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: Image(
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                image: AssetImage(Images.ic_back),
              ),
            ),
          ),*/
          leading: IconButton(icon: Icon(CupertinoIcons.chevron_back), onPressed: () async{

            await viewModel.storeInsideTheDB(data);
            navigationService.popAllAndPushNamed(Routes.dashboard);
          },
          color: Colors.black,iconSize: 25,
          ),
          titleSpacing: 0,
          centerTitle: false,
          title: Text(
            "Image Information",
            style: AppTextStyle.subText.copyWith(
              color: AppColor.textOnBackground,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 230,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Image(
                    width: double.infinity,

                    image: FileImage(data["file"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              VerticalSpacing.custom(value: 12),
              Text(data["date"],style: AppTextStyle.overline.copyWith(
                  fontSize: 12,
                  //  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B779A))),
              VerticalSpacing.custom(value: 8),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'CVS SCORE :',
                    style: AppTextStyle.headLine2.copyWith(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " ${data["total"].toString()}",
                    style: AppTextStyle.headLine2.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary)),
              ])),
              VerticalSpacing.custom(value: 13),
              Text("C1",
                  style: AppTextStyle.headLine2.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B779A))),
              VerticalSpacing.custom(value: 8),
              Text(data["c1_des"].toString(),
                  style: AppTextStyle.overline.copyWith(
                      fontSize: 12,
                     // fontStyle: FontStyle.italic,
                      color: Color(0xFF6B779A))),
              VerticalSpacing.custom(value: 12),
              Container(
                height: .6,
                width: double.infinity,
                color: Color(0xFFDDDDDD),
              ),
              VerticalSpacing.custom(value: 12),
              Text("C2",
                  style: AppTextStyle.headLine2.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B779A))),
              VerticalSpacing.custom(value: 8),
              Text(data["c2_des"].toString(),
                  style: AppTextStyle.overline.copyWith(
                      fontSize: 12,
                  //    fontStyle: FontStyle.italic,
                      color: Color(0xFF6B779A))),
              VerticalSpacing.custom(value: 12),
              Container(
                height: .6,
                width: double.infinity,
                color: Color(0xFFDDDDDD),
              ),
              VerticalSpacing.custom(value: 12),
              Text("C3",
                  style: AppTextStyle.headLine2.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B779A))),
              VerticalSpacing.custom(value: 8),
              Text(data["c3_des"].toString(),
                  style: AppTextStyle.overline.copyWith(
                      fontSize: 12,
                    //  fontStyle: FontStyle.italic,
                      color: Color(0xFF6B779A))),
              VerticalSpacing.custom(value: 12),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async{
                   // await viewModel.storeInsideTheDB(data);
                    navigationService.popAllAndPushNamed(Routes.camera);

                    },
                  child: Container(

                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.primary, width: 1)),
                    alignment: Alignment.center,
                    child: Text(
                      "Retry",
                      style: AppTextStyle.headLine2.copyWith(
                          fontSize: 16,
                          color: AppColor.textOnPrimary,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              HorizontalSpacing.custom(value: 16),
              Expanded(
                child: GestureDetector(
                  onTap: viewModel.buttonLoading
                      ? null
                      : () {
                          viewModel.controlButtonLoading(true);
                          viewModel.gotoPatientInfoScreen(data);
                        },
                  child: Container(

                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.primary,
                      // border: Border.all(color:AppColor.background,width: 1)
                    ),
                    alignment: Alignment.center,
                    child: viewModel.buttonLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ))
                        : Text(
                            "Next",
                            style: AppTextStyle.subText.copyWith(
                                fontSize: 16,
                                color: AppColor.background,
                                fontWeight: FontWeight.w400),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ImageInfoScreen(this.data);
}
