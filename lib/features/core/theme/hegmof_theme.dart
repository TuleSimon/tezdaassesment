import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tezdaassesment/features/core/theme/app_colors.dart';

const Map<int, Color> colorSwatch = {
  50: Color.fromRGBO(253, 175, 59, .1),
  100: Color.fromRGBO(253, 175, 59, .2),
  200: Color.fromRGBO(253, 175, 59, .3),
  300: Color.fromRGBO(253, 175, 59, .4),
  400: Color.fromRGBO(253, 175, 59, .5),
  500: Color.fromRGBO(253, 175, 59, .6),
  600: Color.fromRGBO(253, 175, 59, .7),
  700: Color.fromRGBO(253, 175, 59, .8),
  800: Color.fromRGBO(253, 175, 59, .9),
  900: Color.fromRGBO(185, 113, 5, 1.0),
};

final AppThemeLight = ThemeData(
    colorScheme: ColorScheme(
      primary: AppColors.primaryColor,
      primaryContainer: colorSwatch[500],
      secondary: AppColors.primaryBlue,
      surface: AppColors.backgroundColor,
      error: AppColors.errorColor,
      onPrimary: Colors.white,
      onSecondary: AppColors.onPrimary,
      onSurface: AppColors.textColor,
      onSurfaceVariant: AppColors.textHeaderColor,
      onError: Colors.white,
      surfaceContainer: AppColors.surfaceOnBackground,
      onErrorContainer: AppColors.onPrimary,
      background: AppColors.backgroundColor,
      tertiary: AppColors.successColor,
      errorContainer: AppColors.errorColor.withOpacity(0.6),
      brightness: Brightness.light,
    ),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    cardColor: AppColors.cardColor,
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.primaryColor.value, colorSwatch),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.rubikTextTheme().titleLarge?.copyWith(
          fontSize: 25.sp,
          fontFamilyFallback: ["Roboto"],
          color: AppColors.textHeaderColor,
          fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.rubikTextTheme().titleMedium?.copyWith(
          fontSize: 20.sp,
          fontFamilyFallback: ["Roboto"],
          color: AppColors.textHeaderColor,
          fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.rubikTextTheme().titleSmall?.copyWith(
          fontSize: 14.sp,
          fontFamilyFallback: ["Roboto"],
          color: AppColors.textHeaderColor,
          fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.rubikTextTheme().headlineSmall?.copyWith(
          fontSize: 12.sp,
          fontFamilyFallback: ["Roboto"],
          color: AppColors.textColor),
      headlineMedium: GoogleFonts.rubikTextTheme().headlineMedium?.copyWith(
          fontSize: 14.sp,
          fontFamilyFallback: ["Roboto"],
          color: AppColors.textColor),
      headlineLarge: GoogleFonts.rubikTextTheme().headlineLarge?.copyWith(
          fontSize: 16.sp,
          fontFamilyFallback: ["Roboto"],
          color: AppColors.textHeaderColor),
      bodyLarge: GoogleFonts.krubTextTheme().bodyLarge?.copyWith(
            fontSize: 16.sp,
            fontFamilyFallback: ["Roboto"],
            color: AppColors.textColor,
          ),
      bodyMedium: GoogleFonts.krubTextTheme().bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontFamilyFallback: ["Roboto"],
          color: AppColors.textColor,
          fontWeight: FontWeight.w500),
      bodySmall: GoogleFonts.krubTextTheme().bodySmall?.copyWith(
            fontSize: 12.sp,
            fontFamilyFallback: ["Roboto"],
            color: AppColors.textColor,
          ),
      labelSmall: GoogleFonts.krubTextTheme().labelSmall?.copyWith(
            fontSize: 12.sp,
            fontFamilyFallback: ["Roboto"],
            color: AppColors.textHeaderColor,
          ),
      labelMedium: GoogleFonts.krubTextTheme().labelMedium?.copyWith(
            fontSize: 14.sp,
            fontFamilyFallback: ["Roboto"],
            color: AppColors.textHeaderColor,
          ),
      labelLarge: GoogleFonts.krubTextTheme().labelLarge?.copyWith(
            fontSize: 14.sp,
            fontFamilyFallback: ["Roboto"],
            color: AppColors.textColor,
          ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.surfaceOnBackground,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.w),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.w),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      labelStyle: GoogleFonts.krubTextTheme().labelSmall?.copyWith(
            fontSize: 12.sp,
            color: AppColors.textColor,
          ),
      hintStyle: TextStyle(
        color: AppColors.textColor.withOpacity(0.6),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 20.w),
            foregroundColor: AppColors.textHeaderColor,
            textStyle: GoogleFonts.krubTextTheme().bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHeaderColor,
                ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w)))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
            foregroundColor: AppColors.primaryColor,
            textStyle: GoogleFonts.krubTextTheme().bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
            side: const BorderSide(color: AppColors.primaryColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w)))),
    iconTheme: IconThemeData(color: AppColors.textColor, size: 22.w),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
            iconColor: const WidgetStatePropertyAll(AppColors.textColor),
            iconSize: WidgetStatePropertyAll(20.w))),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.successColor; // Active track color
          }
          return AppColors.textColor; // Inactive track color
        },
      ),
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white; // Active thumb color
          }
          return Colors.white; // Inactive thumb color
        },
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue.withOpacity(0.5); // Active overlay color
          }
          return Colors.grey.withOpacity(0.5); // Inactive overlay color
        },
      ),
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: AppColors.backgroundColor,
    ),
    buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w))),
    canvasColor: AppColors.backgroundColor);

final AppThemeDark = ThemeData(
    colorScheme: AppThemeLight.colorScheme.copyWith(
      primary: AppColorsDark.primaryColor,
      surface: AppColorsDark.backgroundColor,
      error: AppColorsDark.errorColor,
      onPrimary: Colors.white,
      surfaceContainer: AppColorsDark.surfaceOnBackground,
      onSecondary: AppColors.textHeaderColor,
      onSurface: AppColorsDark.textColor,
      onSurfaceVariant: AppColorsDark.textHeaderColor,
      onError: Colors.white,
      onErrorContainer: AppColorsDark.onPrimary,
      errorContainer: AppColorsDark.errorColor.withOpacity(0.6),
      brightness: Brightness.dark,
    ),
    primaryColor: AppColorsDark.primaryColor,
    scaffoldBackgroundColor: AppColorsDark.backgroundColor,
    cardColor: AppColorsDark.cardColor,
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(AppColorsDark.primaryColor.value, colorSwatch),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      titleLarge: AppThemeLight.textTheme.titleLarge?.copyWith(
        color: AppColorsDark.textHeaderColor,
      ),
      titleMedium: AppThemeLight.textTheme.titleMedium?.copyWith(
        color: AppColorsDark.textHeaderColor,
      ),
      titleSmall: AppThemeLight.textTheme.titleSmall?.copyWith(
        color: AppColorsDark.textHeaderColor,
      ),
      headlineSmall: AppThemeLight.textTheme.headlineSmall
          ?.copyWith(color: AppColorsDark.textColor),
      headlineMedium: AppThemeLight.textTheme.headlineMedium
          ?.copyWith(color: AppColors.textColor),
      headlineLarge: AppThemeLight.textTheme.headlineLarge
          ?.copyWith(color: AppColorsDark.textHeaderColor),
      bodyLarge: AppThemeLight.textTheme.bodyLarge?.copyWith(
        color: AppColors.textColor,
      ),
      bodyMedium: AppThemeLight.textTheme.bodyMedium?.copyWith(
        color: AppColorsDark.textColor,
      ),
      bodySmall: GoogleFonts.krubTextTheme().bodySmall?.copyWith(
            fontSize: 12.sp,
            color: AppColorsDark.textColor,
          ),
      labelSmall: GoogleFonts.krubTextTheme().labelSmall?.copyWith(
            fontSize: 12.sp,
            color: AppColorsDark.textColor,
          ),
      labelMedium: GoogleFonts.krubTextTheme().labelMedium?.copyWith(
            fontSize: 14.sp,
            color: AppColorsDark.textColor,
          ),
      labelLarge: GoogleFonts.krubTextTheme().labelLarge?.copyWith(
            fontSize: 14.sp,
            color: AppColorsDark.textColor,
          ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColorsDark.surfaceOnBackground,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.w),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.w),
        borderSide: const BorderSide(color: AppColorsDark.primaryColor),
      ),
      labelStyle: GoogleFonts.krubTextTheme().labelSmall?.copyWith(
            fontSize: 12.sp,
            color: AppColorsDark.textColor,
          ),
      hintStyle: GoogleFonts.krubTextTheme().bodySmall?.copyWith(
            color: AppColorsDark.textColor.withOpacity(0.6),
          ),
    ),
    iconTheme: IconThemeData(color: AppColorsDark.textColor, size: 22.w),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
            iconColor: const WidgetStatePropertyAll(AppColorsDark.textColor),
            iconSize: WidgetStatePropertyAll(20.w))),
    filledButtonTheme: AppThemeLight.filledButtonTheme,
    outlinedButtonTheme: AppThemeLight.outlinedButtonTheme,
    buttonTheme: AppThemeLight.buttonTheme,
    canvasColor: AppColorsDark.backgroundColor);

final horizontalPadding = EdgeInsets.symmetric(horizontal: 20.w);
final defCornerRadius = 10.w;
