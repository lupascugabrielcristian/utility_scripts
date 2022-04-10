import shutil
import os

vimwiki_files = os.listdir("/home/alex/vimwiki/")
all_count = len(vimwiki_files)
done_count = 0
for f in vimwiki_files:
    destination = "/tmp/obsidian/" + f.replace(".wiki", ".md")
    source = "/home/alex/vimwiki/" + f

    if os.path.isdir(source):
        continue

    shutil.copy(source, destination)
    done_count += 1
    print("%d of %d" % (done_count, all_count) )

