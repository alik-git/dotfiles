import os
import shutil

path = "/home/kuwajerw/"
os.chdir(path)

for dir in os.listdir(path):
    if os.path.isdir(path + dir):
        print(dir)
        for subdir in os.listdir(path + dir):
            sub_path = path + dir + "/"
            if subdir.endswith(".git"):
                source = sub_path
                print("lsafjkja;")
                print(dir)
                dest = r'/home/kuwajerw/repos/' + dir
                print(dest)
                done = shutil.move(source, dest)


                print("--------------------------------------")
                print(sub_path + subdir)
            else:
                print("---", subdir)



