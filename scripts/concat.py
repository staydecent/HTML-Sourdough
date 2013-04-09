# concat.py: HTML-Sourdough. (c) Adrian Unger. Public Domain.
from glob import glob
import shutil
import os
import sys

CWD = os.path.join(os.getcwd() + '/')

def concat(look, dest, before=[], ignore=[], reg='*.js'):
  # type safety
  if ',' in look:
    look = look.split(',')
  if ',' in before:
    before = before.split(',')
  if len(ignore) > 0: # string or non-empty list
    ignore = ignore.split(',')

  if type(look) == list and len(before) > 0:
    print('Both `look` and `before` cannot be lists.')
    return

  destination = open(os.path.join(CWD + dest), 'wb')
  before = map(lambda x: os.path.join(CWD, look, x), before)
  ignore = map(lambda x: os.path.join(CWD, look, x), ignore)

  # set array
  if type(look) == list:
    iterateFiles = map(lambda x: os.path.join(CWD, x), look)
  # look in dir
  else:
    iterateFiles = glob(os.path.join(CWD, look + '/') + reg)

  # ordering?
  if len(before) > 0:
    iterateFiles = before + iterateFiles
    # remove dupes
    seen = set()
    seen_add = seen.add
    iterateFiles = [ x for x in iterateFiles if x not in seen and not seen_add(x)]

  for filename in iterateFiles:
    if filename in ignore:
      continue
    shutil.copyfileobj(open(filename, 'rb'), destination)
    destination.write('\n')

  destination.close()
  print "Concatenated all {0} files in {1} to {2}".format(reg, look, dest)

def main(argv):
  pass
  # need atleast 2 args
  if len(argv) < 2:
    print("Concat takes at least 2 arguments.")
    print("`concat.py look (String or List) dest (String) before (List)`")
    return

  concat(*argv)

if __name__ == '__main__':
  main(sys.argv[1:]) # Skips program name