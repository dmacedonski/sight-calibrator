# Sight Calibrator

Application for calibration of your Red Dot Sight, Holographic Sight, Scope and other.

## Development

### Localizations

Base language is English all strings are located in file `lib/l10n/app_en.arb`.
New translations must be inserted in this same directory and named with format `app_{locale}.arb`.
After updated or added translations run the following command in the terminal.

```shell
flutter gen-l10n
```

### Build

#### Build bundle

```shell
flutter build appbundle
```

#### Build APK

```shell
flutter build apk
```

## License

This project is licensed under the MIT license. Full license text you can find [here](LICENSE.txt).