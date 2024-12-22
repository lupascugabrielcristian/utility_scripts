ta_commands() {
    echo 'ta-login      login with client account'
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
