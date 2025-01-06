alias ta-commands="ta_commands"
ta_commands() {
    echo 'ta-login      login with client account'
    echo 'ta-login-v    login with tedt account'
    echo 'ta-install    install the latest apk build'
    echo 'ta-start      Start the tamato app'
}

alias ta-login="ta_login"
ta_login() {
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text 'client'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text 'lupascugabrielcristian@gmail.com'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text '3q2w3e4rA'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '66' # Enter key
}

alias ta-login-ext="ta_login_ext"
ta_login_ext() {
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text 'client'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text 'contact@binaryfusion.ro'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text 'testInvite123'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '66' # Enter key
}

alias ta-login-v="ta_login_v"
ta_login_v() {
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text 'tedt'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text 'client@w3dsoft.com'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input text '1q2w3e4r'
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '61' # Tab key
    /home/alex/Android/Sdk/platform-tools/adb shell input keyevent '66' # Enter key
}

# Install the latest app-release.apk file from the ouput android folder
alias ta-install="ta_install"
ta_install() {
    /home/alex/Android/Sdk/platform-tools/adb install -r /home/alex/projects/tamato/inventory-system-apps/build/app/outputs/flutter-apk/app-release.apk
}

alias ta-start="ta_start"
ta_start() {
    /home/alex/Android/Sdk/platform-tools/adb shell am start -n com.example.test_drive/.MainActivity
}
