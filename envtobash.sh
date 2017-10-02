#!/bin/bash
grep "^[^#:blank:]" $1 | sed 's/=\(.*$\)/="\1"/g' | sed 's/^/export /g'
