import pyautogui
from random import randrange
# Este instalat in pyenv "move-cursor"

# Total 675

def drag_picture_to_right(count):
    for i in range(count):
        pyautogui.moveTo(2300,300)
        pyautogui.dragTo(4300 + randrange(10, 50) ,300, button='left')
        #pyautogui.dragTo(4300,300, pyautogui.easeInQuad)
        print("Step %d" % i)
#pyautogui.moveTo(4300,300)

def drag_picture_to_left(count):
    for i in range(count):
        pyautogui.moveTo(4300, 300)
        pyautogui.dragTo(2200 + randrange(10, 50), 300, button='left')
        print("Step %d" % i)

drag_picture_to_left(5)
#drag_picture_to_right(125)





