#!/usr/bin/env python3

import re

pattern = r'"[^"]+"|\'[^\']+\'|//(?P<line_comment>.+)|/\*(?P<block_comment>[\s\S]+?)\*/'

def skip_fail(match):
    return '' if match.lastgroup else match.group(0)

input_text = '''public static void Main(string[] args) {
    // Dit is commentaar
    int a = 10; /* In principe kan ik muliline
    comments ook achterwege laten.
    */

    a += 5; // Tot zo ver het voorbeeld
}
'''

comment_free = re.sub(pattern, skip_fail, input_text)
lloc = list(filter(lambda line: line.strip(), comment_free.splitlines()))
loc_count = len(input_text.splitlines())
lloc_count = len(lloc)

print("Code:")
print(input_text)

print("---")
print("Of which logical lines:")
print('\n'.join(lloc))

print("---")
print(f"LOC: {loc_count}, LLOC: {lloc_count}")