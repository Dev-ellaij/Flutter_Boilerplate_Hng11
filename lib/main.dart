import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_hng11/utils/global_colors.dart';
import 'package:flutter_boilerplate_hng11/utils/initializations.dart';
import 'package:flutter_boilerplate_hng11/utils/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_context/one_context.dart';

void main() async {
  await initializeApp();

  // Make app always in portrait
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  // Change status bar theme based on theme of app
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        builder: OneContext().builder,
        key: OneContext().key,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(),
            scaffoldBackgroundColor: Colors.white,
            dialogTheme: DialogTheme(
              backgroundColor:
                  GlobalColors.deemWhiteColor, // Dialog background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Dialog shape
              ),
              elevation: 10, // Dialog elevation
              titleTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Title text style
              ),
              contentTextStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey[800], // Content text style
              ),
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle.dark)),
      ),
    );
  }
}
