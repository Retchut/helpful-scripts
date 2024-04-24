'''
	This script will create soft symlinks in a directory to all files from another directory
    Usage:
        python makelinks.py <recursive (true/false)> <source directory> <destination directory>
    
    Some things of note:
        - The source and destination directories **must** be absolute paths (beginning with '/' or '~' or similar). Don't forget to escape special characters.

        - The script will create the destination directory if it does not already exist

        - If the recursive option is set to true, the script will also create links for all files inside the source directory's subfolders, recursively. Folders for each of these subdirectories will be created, and links will be placed in these newly created folders.
'''

import sys
import os

def make_links(src_dir, dest_dir, create_dirs):

    # checking if we were provided with just a file
    if (os.path.isfile(src_dir)):
        try:
            os.symlink(src_dir, dest_dir)
            return
        except FileExistsError:
            print("File already exists: {}".format(dest_dir))

    files = os.listdir(src_dir)
    for filename in files:
        if (os.path.isfile(src_dir + filename)):
            try:
                os.symlink(src_dir + filename, dest_dir + filename)
            except FileExistsError:
                print("File already exists: {}".format(dest_dir + filename))
        elif (os.path.isdir(src_dir + filename)):
            if(create_dirs):
                new_dir = dest_dir + filename + '/'
                try:
                    os.makedirs(new_dir)
                except FileExistsError:
                    print("Directory \'{}\' already exists -- copying to it".format(new_dir), end='\n\n')

                make_links(src_dir + filename + '/', new_dir, create_dirs)
            else:
                make_links(src_dir + filename + '/', dest_dir, create_dirs)


def main():
    if len(sys.argv) != 4:
        print("Usage: python makelinks.py <recursive (true/false)> <source directory/file> <destination directory/file>")
        sys.exit(1)

    if(sys.argv[1].lower() != 'true' and sys.argv[1].lower() != 'false'):
        print("Argument 1 must be either \'true\' or \'false\'.")
        return
    create_dirs = sys.argv[1].lower() == 'true'
    folder_from = sys.argv[2]
    final_dir = sys.argv[3]

    if(final_dir[-1] != '/'):
        final_dir += '/'

    orig_dir = str(folder_from)

    try:
        os.makedirs(final_dir)
    except FileExistsError:
        print("Directory \'{}\' already exists -- copying to it".format(final_dir), end='\n\n')

    make_links(orig_dir, final_dir, create_dirs)

    print()
    print("\n".join(os.listdir(final_dir + '/../')))

if __name__ == '__main__':
    main()

