import 'dart:io';
import 'package:flutter/material.dart';
import 'package:peto_care/base/blocs/theme_bloc.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import '../../handlers/file_picker_handler.dart';
import '../theme/media.dart';
import '../theme/text_styles.dart';
import 'custom_btn.dart';

class UploadImage extends StatefulWidget {
  final Function(File?)? updatedImage;

  final ValueChanged? updateFile;
  final bool isFilled;
  final bool hasError;
  final String? errorText;
  final String? label;
  final File? selectedImage;

  const UploadImage({super.key, required this.updatedImage, this.label, this.selectedImage, this.isFilled = false, this.updateFile, this.hasError = false, this.errorText});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;

  @override
  Widget build(BuildContext context) {
    image = widget.selectedImage;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: () {
                // ImagePickerHelper.showOption(onGet: (file) async {
                //   setState(() => image = file);
                //   var multipartImage = await MultipartFile.fromFile(image!.path);
                //   widget.updatedImage!(file);
                //   if (widget.updateFile != null) widget.updateFile!(image);
                // });
                FilePickerHelper.pickFile(
                  title: "Pick an Fundus image",
                  allowedExtensions: ['jpg'],
                  onSelected: (file) async {
                    setState(() => image = file);
                    widget.updatedImage!(file);
                    if (widget.updateFile != null) widget.updateFile!(image);
                  },
                );
              },
              child: Container(
                height: image != null ? 230 : 180,
                width: MediaHelper.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 1,
                      color: widget.isFilled ? themeBloc.theme.valueOrNull!.primary : (widget.hasError ? themeBloc.theme.valueOrNull!.inActive : themeBloc.theme.valueOrNull!.borderColor),
                    )
                    // image: DecorationImage(
                    //     image: Image.asset(
                    //             'assets/images/${image != null ? "uploaded_image" : "upload_image"}.png')
                    //         .image,
                    //     fit: BoxFit.fill),
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                        child: image != null
                            ? Image.file(
                                image!,
                                fit: BoxFit.contain,
                              )
                            : drawSvgIcon(
                                'gallery',
                                iconColor: (widget.hasError ? themeBloc.theme.valueOrNull!.error : themeBloc.theme.valueOrNull!.error),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      image != null
                          ? "Uploaded!"
                          : widget.label != null
                              ? widget.label!
                              : "Upload Image",
                      style: TextStyle(color: themeBloc.theme.valueOrNull!.greyTitle, fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    //   child: RichText(
                    //     text: TextSpan(text: image != null ? basename(image!.path) : 'must be less than', style: TextStyle(color: AppColors.subHeader, fontSize: 11, fontWeight: FontWeight.w500), children: [TextSpan(text: image != null ? "" : ' 6MB', style: TextStyle(color: AppColors.header, fontSize: 11, fontWeight: FontWeight.w600))]),
                    //     textAlign: TextAlign.center,
                    //     maxLines: 2,
                    //   ),
                    // ),
                    Visibility(
                      visible: image != null,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomBtn(
                                    text: Text("Change"),
                                    height: 56,
                                    onTap: () {
                                      FilePickerHelper.pickFile(
                                          title: "Pick an Fundus image",
                                          allowedExtensions: ['jpg'],
                                          onSelected: (file) async {
                                            setState(() => image = file);
                                            widget.updatedImage!(file);
                                            if (widget.updateFile != null) widget.updateFile!(image);
                                          });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: CustomBtn(
                                    text:Text( "Remove"),
                                    height: 56,
                                    onTap: () {
                                      setState(() => image = null);
                                      widget.updatedImage!(null);
                                      if (widget.updateFile != null) widget.updateFile!(null);
                                    },
                                    buttonColor: themeBloc.theme.valueOrNull!.inActive.withOpacity(.1),
                                    textColor: themeBloc.theme.valueOrNull!.inActive,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.hasError)
          Text(
            widget.errorText ?? "",
            style: AppTextStyles.w400.copyWith(fontSize: 14, color: themeBloc.theme.valueOrNull!.inActive),
          )
      ],
    );
  }
}
