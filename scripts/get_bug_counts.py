#!/usr/bin/env python
from __future__ import print_function

import os
import sys
#import sqlite3

from launchpadlib import launchpad

#LP_DB = os.path.expanduser('~/.launchpadlib/tripleo')
LP_CACHE_DIR = os.path.expanduser('~/.launchpadlib/cache')
LP_OPEN_STATUS = ['New', 'Incomplete', 'Confirmed', 'Triaged', 'In Progress']
LP_CLOSED_STATUS = ['Fix Released', 'Fix Committed']
LP_EXPIRED_STATUS = ['Expired']

#def connect_db():
#    conn = sqlite3.connect(LP_DB)
#    return conn

def login():
    lp = launchpad.Launchpad.login_anonymously('tripleo-report',
                                               'production',
                                               LP_CACHE_DIR,
                                               version='devel')
    return lp


def main():
    lp = login()
    lpt = lp.projects['tripleo']
    milestones = lpt.active_milestones

    tags = lpt.official_bug_tags
    #tags = ['ui', 'tech-debt']

    print("{}".format(",".join(['tag']+LP_OPEN_STATUS)))
    for T in tags:
        res = [T]
        for S in LP_OPEN_STATUS:
            bugs = lpt.searchTasks(tags=T, status=S)
            res = res + [str(len(bugs))]
        print("{}".format(",".join(res)))


if __name__ == "__main__":
    main()
