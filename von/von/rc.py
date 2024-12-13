import os

# Pick a path to store the problems in
VON_BASE_PATH  = os.path.join(os.environ.get("HOME", ""), "Dropbox (MIT)/VON/")

VON_INDEX_NAME = "index"
VON_INDEX_PATH = os.path.join(VON_BASE_PATH, VON_INDEX_NAME)
VON_CACHE_NAME = "cache"
VON_CACHE_PATH = os.path.join(VON_BASE_PATH, VON_CACHE_NAME)

EDITOR = os.environ.get('EDITOR','nvim') # that easy!
BACKUP_DIR = "~/.config/nvim/tmp/" # a directory for storing backups

SEPERATOR = '\n---\n'
NSEPERATOR = '\n' + SEPERATOR + '\n'

TAG_HINT_TEXT = """# Any text you want to display on the YAML editor.
# For example, a list of tags to use."""

USE_COLOR = True

# These particular tags are used for difficulty, and are highlighted differently
# Also used in sorting. Should be in increasing order.
DIFFS= ['ctrivial', 'ceasy', 'cmedium', 'ctricky', 'chard', 'cbrutal',\
        'trivial', 'easy', 'medium', 'tricky', 'hard', 'brutal']

# vim: ft=python
