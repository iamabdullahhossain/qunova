import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qunova/core/config/app_color.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../routes/routes.dart';

class AppGlobalFunctions {
  AppGlobalFunctions._();

  /*Use this function in case if you are willing to print or debug something. This function will help you to hide your debug print in release mode.*/
  static void logDebug(String message) {
    if (kDebugMode) {
      debugPrint("🦊 $message");
    }
  }
 static String getTimeAgo(String timeString) {
    final dateTime = DateTime.parse(timeString);
    return timeago.format(dateTime);
  }



  static String formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  /*static Future<void> datePicker(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: colors(context).primaryColor,
              onPrimary: colors(context).buttonColor,
              onSurface: colors(context).bodyTextColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Always update the date provider with the selected date in YYYY-MM-DD format
      ref.read(dateTextProvider.notifier).state = formatDate(picked);
      logDebug(ref.read(dateTextProvider.notifier).state);
    }
  }*/

  static Future<void> downloadAndOpenFile(String url) async {
    // Determine filename and platform-specific save directory
    String fileName = url.split('/').last;

    try {
      Directory saveDir;

      if (Platform.isAndroid) {
        // Request storage permission on Android
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          AppGlobalFunctions.logDebug(
            'Storage permission not granted. Cannot save file to external storage.',
          );
          // Fallback to app-specific external directory
          // saveDir = (await getExternalStorageDirectory()) ?? await getApplicationDocumentsDirectory();
          saveDir = Directory('/storage/emulated/0/Download');
        } else {
          // Prefer public Downloads folder so user can find the file
          saveDir = Directory('/storage/emulated/0/Download');
          if (!await saveDir.exists()) {
            // Fallback to external storage directory provided by path_provider
            //saveDir = (await getExternalStorageDirectory()) ?? await getApplicationDocumentsDirectory();
            saveDir = Directory('/storage/emulated/0/Download');
          }
        }
      } else if (Platform.isIOS) {
        // iOS: saving to application documents directory is visible via the Files app
        saveDir = await getApplicationDocumentsDirectory();
      } else {
        // Other platforms: use application documents
        saveDir = await getApplicationDocumentsDirectory();
      }

      // Ensure the directory exists
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      final savePath = '${saveDir.path}/$fileName';
      AppGlobalFunctions.logDebug('Saving file to: $savePath');

      // Download the file
      Dio dio = Dio();
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            AppGlobalFunctions.logDebug('Download progress: $progress%');
          }
        },
      );

      final downloadedFile = File(savePath);
      if (await downloadedFile.exists()) {
        AppGlobalFunctions.logDebug(
          'Download complete and file exists: $savePath',
        );
        // Open the file
        await OpenFilex.open(savePath);
      } else {
        AppGlobalFunctions.logDebug(
          'Download finished but file does not exist at path: $savePath',
        );
      }
    } catch (e, st) {
      AppGlobalFunctions.logDebug('Download error: $e');
      AppGlobalFunctions.logDebug('$st');
    }
  }

/*
  static Widget appBar(
    BuildContext context,
    String pageName,

    VoidCallback onPressed, {
    double? height,
    String? image,
    String? lastSeen,
    String? optionImage,
    VoidCallback? onDetailsTap,
    bool? notification = false,
    bool? isOnline = false,
  }) {
    return CustomContainer(
      context: context,
      height: height ?? 70.h,
      color: colors(context).appBarColor,
      boxShadow: [],
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onPressed,
              child: Image.asset(
                "assets/icons/back_button.png",
                width: 32,
                height: 32,
              ),
            ),
          ),

          //for chat
          (image == null)
              ? Center(
                  child: Text(
                    pageName,
                    style: AppTextStyle(context).title.copyWith(
                      color: colors(context).bodyTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                )
              : Positioned(
                  left: 50.w,
                  right: 0.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38.w,
                            height: 38.h,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                              shape: OvalBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: AppStaticColor.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          Gap(10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pageName,
                                style: AppTextStyle(context).title.copyWith(
                                  color: colors(context).bodyTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                (isOnline == true)
                                    ? S.of(context).activeNow
                                    : lastSeen ?? "",
                                style: AppTextStyle(context).subTitle.copyWith(
                                  color: colors(context).hintTextColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      */
/*  InkWell(
                        onTap: onDetailsTap,
                        child: Image.asset(
                          "assets/icons/three_dot.png",
                          height: 24.h,
                          width: 24.w,
                          color: colors(context).buttonTextColor,
                        ),
                      ),*//*

                    ],
                  ),
                ),

          //for notificationScreen
          (notification == true)
              ? Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: InkWell(
                    onTap: onDetailsTap,
                    child: Text(S.of(context).markAllAsRead),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
*/

/*  static Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      return "${android.brand} ${android.model}";
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      return "${ios.name} (${ios.model})";
    } else {
      return "Unknown Device";
    }
  }

  static void pickedImage(WidgetRef ref) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      ref.read(imagePickerProvider.notifier).state = image;
    } else {
      return;
    }
  }*/

  static void showCustomSnackbar({
    required String message,
    required bool isSuccess,
    bool isTop = false,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      dismissDirection: isTop
          ? DismissDirection.startToEnd
          : DismissDirection.down,
      backgroundColor: isSuccess
          ? AppStaticColor.successColor
          : AppStaticColor.errorColor,
      content: Text(
        message,
        style: TextStyle(color: AppStaticColor.whiteColor),
      ),
      margin: isTop
          ? EdgeInsets.only(
              bottom: MediaQuery.of(currentContext!).size.height - 160,
              right: 20,
              left: 20,
            )
          : null,
    );
    ScaffoldMessenger.of(currentContext!).showSnackBar(snackBar);
  }

  /*static noItemFound({
    String? text,
    double? size,
    required BuildContext context,
  }) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double adjustedHeight = (screenHeight - 200).clamp(
      0.0,
      double.infinity,
    );

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: size ?? adjustedHeight,
        //height: size ?? MediaQuery.of(context).size.height - 200,
        child: Center(
          child: Text(
            text!,
            *//*?? S.of(context).noDataFound*//*
            style: AppTextStyle(context).bodyTextSmall,
          ),
        ),
      ),
    );
  }*/

/*  static (String, Color, Color) getStatus(String status, BuildContext context) {
    switch (status) {
      case 'todo':
        return (
          S.of(context).toDo,
          AppStaticColor.warningColor,
          Color(0xF5FFFCB0),
        );
      case 'inprogress':
        return (
          S.of(context).inProgress,
          AppStaticColor.infoColor,
          Color(0xFFD4E6FF),
        );
      case 'completed':
        return (
          S.of(context).completed,
          AppStaticColor.successColor,
          Color(0xC5BFF1BA),
        );
      case 'incomplete':
        return (
          S.of(context).inComplete,
          AppStaticColor.errorColor,
          Color(0xCBFFAA93),
        );
      default:
        return ('', AppStaticColor.blackColor, AppStaticColor.blackColor);
    }
  }

  static (String, Color, Color) getPriority(
    String status,
    BuildContext context,
  ) {
    switch (status) {
      case 'high':
        return (
          S.of(context).high,
          AppStaticColor.errorColor,
          Color(0xCBFFAA93),
        );
      case 'medium':
        return (
          S.of(context).medium,
          AppStaticColor.infoColor,
          Color(0xFFD4E6FF),
        );
      case 'low':
        return (
          S.of(context).low,
          AppStaticColor.successColor,
          Color(0xC5BFF1BA),
        );
      default:
        return ('', AppStaticColor.blackColor, AppStaticColor.blackColor);
    }
  }*/

  /* static void changeStatusBarColor({
    required Color color,
    Brightness? iconBrightness,
    Brightness? brightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color, //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness:
            iconBrightness ?? Brightness.dark, // For Android (dark icons)
        statusBarBrightness: brightness ?? Brightness.light,
      ),
    );
  }

  static String convertMinutesToHours(int minutes, BuildContext context) {
    int hours = (minutes / 60).floor();
    int remainingMinutes = minutes % 60;
    if (hours == 0 && remainingMinutes == 0) return '0 ${S.of(context).min}';
    if (hours == 0) return '$remainingMinutes ${S.of(context).min}';
    if (remainingMinutes == 0) return '$hours ${S.of(context).hour}';

    return '$hours ${S.of(context).hour} $remainingMinutes ${S.of(context).min}';
  }


  static cAppBar({bool showLogo = false, required Widget header}) {
    return AppBar(
      title: header,
      actions: [
        ValueListenableBuilder(
            valueListenable: Hive.box(AppHSC.userBox).listenable(),
            builder: (context, userBox, _) {
              String? image;
              final bool isGuest =
                  userBox.get(AppHSC.isGuest, defaultValue: true) as bool;
              if (!isGuest) {
                final Map<dynamic, dynamic> userData =
                    userBox.get(AppHSC.userInfo) ?? {};
                Map<String, dynamic> userInfoStringKeys =
                    userData.cast<String, dynamic>();
                final userInfo = User.fromMap(userInfoStringKeys);
                image = userInfo.profilePicture;
              }

              //old code from hive
              // final Map<dynamic, dynamic> userData = userBox.values.first;

              return Consumer(builder: (context, ref, _) {
                return Container(
                    //width: 32.h,
                    height: 32.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Row(
                      spacing: 15,
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.nav
                                    .pushNamed(Routes.notificationScreen);
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.h),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/svg/ic_notification.svg',
                                      color: colors(context)
                                          .primaryColor!
                                          .withOpacity(.8),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                            Consumer(
                              builder: (context, ref, _) {
                                final notificationState =
                                    ref.watch(notificationProvider);
                                return notificationState.maybeWhen(
                                  data: (data) {
                                    int unReadMessage = ref
                                        .read(notificationProvider.notifier)
                                        .unReadCount();
                                    return (unReadMessage > 0)
                                        ? Positioned(
                                            right: 6.h,
                                            top: 2.h,
                                            child: GestureDetector(
                                              onTap: () {
                                                context.nav.pushNamed(
                                                    Routes.notificationScreen);
                                              },
                                              child: Container(
                                                width: 16.h,
                                                height: 16.h,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: context
                                                            .color.surface,
                                                        width: 1.2.h),
                                                    shape: BoxShape.circle,
                                                    color: AppStaticColor
                                                        .redColor),
                                                child: Center(
                                                  child: Text(
                                                    unReadMessage > 9
                                                        ? '$unReadMessage+'
                                                        : unReadMessage
                                                            .toString(),
                                                    style: AppTextStyle(context)
                                                        .bodyTextSmall
                                                        .copyWith(
                                                            color: context
                                                                .color.surface,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 8.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink();
                                  },
                                  orElse: () => Container(),
                                );
                              },
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            ref.read(homeTabControllerProvider.notifier).state =
                                3;
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.h),
                            child: image == null
                                ? Center(
                                    child: Image.asset(
                                      'assets/png/im_demo_user_1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : FadeInImage.assetNetwork(
                                    placeholder: 'assets/png/spinner.gif',
                                    image: image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ));
              });
            }),
        16.pw
      ],
    );
  }


  static prepareShortAndFilterData(BuildContext context) {
    shortFilterList = [
      ShortFilter(S.of(context).cDefault, ''),
      ShortFilter(S.of(context).hToL, 'desc'),
      ShortFilter(S.of(context).lToH, 'asc'),
    ];
    shortBasicFilterList = [
      ShortFilter(S.of(context).newFirst, 'published_at'),
      ShortFilter(S.of(context).popularFirst, 'view_count'),
      ShortFilter(S.of(context).longDurationFirst, 'total_duration'),
      ShortFilter(S.of(context).cDefault, ''),
    ];
    ratingFilterList = [
      ShortFilter('5.0', '5'),
      ShortFilter('4.0', '4'),
      ShortFilter('3.0', '3'),
      ShortFilter('2.0', '2'),
      ShortFilter('1.0', '1'),
    ];
  }





  static getPickImageAlert(
      {required BuildContext context,
      required VoidCallback pressCamera,
      required VoidCallback pressGallery}) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (context) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: pressGallery,
                child: Container(
                  margin: EdgeInsets.only(bottom: 1.w),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: ListTile(
                    leading: const Icon(
                      Icons.attach_file,
                    ),
                    title: Text(S.of(context).uploadFromGallery),
                  ),
                ),
              ),
              InkWell(
                onTap: pressCamera,
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: ListTile(
                    leading: const Icon(
                      Icons.add_a_photo,
                    ),
                    title: Text(S.of(context).takePhoto),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String toDateFormateMinHouDayWeekDateAgo(
      String dateTime, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(DateTime.parse(dateTime));

    if (difference.inSeconds < 60) {
      return S.of(context).justNow;
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${S.of(context).minutes} ${S.of(context).ago}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${S.of(context).hours} ${S.of(context).ago}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${S.of(context).days} ${S.of(context).ago}';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? S.of(context).week : S.of(context).weeks} ${S.of(context).ago}';
    } else {
      return DateFormat('MMM dd, yyyy').format(DateTime.parse(dateTime));
    }
  }

  static String toHourMinute(
      {required int time, required BuildContext context}) {
    Duration duration = Duration(seconds: time);

    String hoursString = duration.inHours > 0
        ? '${duration.inHours} ${S.of(context).hours} '
        : '';
    String minutesString = duration.inMinutes.remainder(60) > 0
        ? '${duration.inMinutes.remainder(60)} ${S.of(context).minute} '
        : '';

    return '$hoursString$minutesString';
  }

  static showBottomSheet({
    required BuildContext context,
    required Widget widget,
    bool isDismissible = false,
    bool enableDrag = true,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      showDragHandle: false,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      elevation: 0,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: context.color.surface,
      // TODO: Remove when this is in the framework https://github.com/flutter/flutter/issues/118619
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (context) {
        return widget;
      },
    );
  }

  static String getFileIcon(String type) {
    if (FileSystem.audio.name == type) {
      return 'assets/svg/ic_audio_file.svg';
    }
    if (FileSystem.video.name == type) {
      return 'assets/svg/ic_video_file.svg';
    }
    if (FileSystem.document.name == type) {
      return 'assets/svg/ic_note_file.svg';
    }
    return 'assets/svg/ic_image_file.svg';
  }

  static Future<String?> getPath() async {
    if (Platform.isAndroid) {
      await Permission.storage.request();
    }
    Directory? appDocDir;

    if (Platform.isAndroid) {
      appDocDir = Directory('/storage/emulated/0/Download');
      if (!await appDocDir.exists()) {
        appDocDir = await getExternalStorageDirectory();
      }
    } else if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
    return appDocDir?.path;
  }

  static showSnacbarMethod({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        content: Text(message),
      ),
    );
  }

  static GlobalKey<ScaffoldMessengerState> getSnackbarKey() {
    final snackbarKey = GlobalKey<ScaffoldMessengerState>();
    return snackbarKey;
  }*/

  static final currentContext = AppRouter.navigatorKey.currentContext;
}
