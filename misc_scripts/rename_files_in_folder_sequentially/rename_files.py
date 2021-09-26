import os
import re
import shutil

_src = "/mnt/MyStuff/Media/Pictures/600d/2/"
_ext = ".JPG"

endsWithNumber = re.compile(r'(\d+)'+(re.escape(_ext))+'$')
for filename in os.listdir(_src):
    m = endsWithNumber.search(filename)
    if m:
        old_name = filename
        new_name = 'IMG_1' + str(m.group(1)).zfill(3)+_ext
        print("Turing {} into {}".format(old_name, new_name))
        # os.rename(filename, _src+new_name)
        shutil.move(_src+filename, _src+new_name)
    else:
        # os.rename(filename, _src+'People-' + str(0).zfill(3)+_ext)
        print("Huh! weird name")
        exit()