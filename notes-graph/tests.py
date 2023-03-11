import re

def get_links(line):
    pattern = re.compile("\[\[([\w:.|\/]*)\]\]")

    if pattern.search(line) is None:
        return []

    link_segments_incomplete = line.split("[[")
    link_segments_incomplete = list(filter(lambda s: len(s) > 0, link_segments_incomplete ))
    link_segments_complete = list(map(lambda s: "[[" + s, link_segments_incomplete))

    search_results = list(map(lambda s: pattern.search(s), link_segments_complete))
    search_results = list(filter(lambda s: s is not None and len(s.groups()) > 0, search_results))
    search_results = list(map(lambda s: s.group(1), search_results))

    return search_results


def finds_link_alone():
    return get_links("[[some_link]]")

def finds_double_links():
    line_with_link = "[[some_link]] [[other_link]]"

    pattern = re.compile("\[\[(.*)\]\]")
    search_result = pattern.search(line_with_link)
    return search_result.group(1)


get_links("[[some_link]]") == ["some_link"] and print("[OK] single link") 

double_link_result = get_links("[[some_link]] [[other_link]]") 
len(double_link_result) == 2 and \
    double_link_result[0] == "some_link" and \
    double_link_result[1] == "other_link" and print("[OK] double link")

len( get_links("[[some_incomplete_link") ) == 0 and print("[OK] link missing right")
len( get_links("some_incomplete_link]]") ) == 0 and print("[OK] link missing left")

res = get_links("[[complete_link]] some_incomplete_link]]")
len( res ) == 1 and \
    res[0] == "complete_link" and \
    print("[OK] mixed complete with incomplete")

res = get_links("[[www.url.com|some_link]]")
len( res ) == 1 and \
    res[0] == "www.url.com|some_link" and \
    print("[OK] www link")

res = get_links("[[https://www.url.com|some_link]]")
len( res ) == 1 and \
    res[0] == "https://www.url.com|some_link" and \
    print("[OK] http link")
