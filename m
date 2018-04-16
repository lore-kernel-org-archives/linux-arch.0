From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model 1/5] EXP tools/memory-model: Add scripts to test memory model
Date: Mon, 16 Apr 2018 09:22:47 -0700
Message-ID: <1523895771-19224-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180416162228.GA18167@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416162228.GA18167@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

This commit adds a pair of scripts that run the memory model on litmus
tests, checking that the verification result of each litmus test matches
the result flagged in the litmus test itself.  These scripts permit easier
checking of changes to the memory model against preconceived notions.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/litmus-tests/.gitignore   |  1 +
 tools/memory-model/scripts/checkalllitmus.sh | 73 +++++++++++++++++++++++
 tools/memory-model/scripts/checklitmus.sh    | 86 ++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/.gitignore
 create mode 100755 tools/memory-model/scripts/checkalllitmus.sh
 create mode 100755 tools/memory-model/scripts/checklitmus.sh

diff --git a/tools/memory-model/litmus-tests/.gitignore b/tools/memory-model/litmus-tests/.gitignore
new file mode 100644
index 000000000000..6e2ddc54152f
--- /dev/null
+++ b/tools/memory-model/litmus-tests/.gitignore
@@ -0,0 +1 @@
+*.litmus.out
diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
new file mode 100755
index 000000000000..af0aa15ab84e
--- /dev/null
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+#
+# Run herd tests on all .litmus files in the specified directory (which
+# defaults to litmus-tests) and check each file's result against a "Result:"
+# comment within that litmus test.  If the verification result does not
+# match that specified in the litmus test, this script prints an error
+# message prefixed with "^^^".  It also outputs verification results to
+# a file whose name is that of the specified litmus test, but with ".out"
+# appended.
+#
+# Usage:
+#	sh checkalllitmus.sh [ directory ]
+#
+# The LINUX_HERD_OPTIONS environment variable may be used to specify
+# arguments to herd, whose default is defined by the checklitmus.sh script.
+# Thus, one would normally run this in the directory containing the memory
+# model, specifying the pathname of the litmus test to check.
+#
+# This script makes no attempt to run the litmus tests concurrently.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, you can access it online at
+# http://www.gnu.org/licenses/gpl-2.0.html.
+#
+# Copyright IBM Corporation, 2018
+#
+# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+
+litmusdir=${1-litmus-tests}
+if test -d "$litmusdir" -a -r "$litmusdir" -a -x "$litmusdir"
+then
+	:
+else
+	echo ' --- ' error: $litmusdir is not an accessible directory
+	exit 255
+fi
+
+# Find the checklitmus script.  If it is not where we expect it, then
+# assume that the caller has the PATH environment variable set
+# appropriately.
+if test -x scripts/checklitmus.sh
+then
+	clscript=scripts/checklitmus.sh
+else
+	clscript=checklitmus.sh
+fi
+
+# Run the script on all the litmus tests in the specified directory
+ret=0
+for i in litmus-tests/*.litmus
+do
+	if ! $clscript $i
+	then
+		ret=1
+	fi
+done
+if test "$ret" -ne 0
+then
+	echo " ^^^ VERIFICATION MISMATCHES"
+else
+	echo All litmus tests verified as was expected.
+fi
+exit $ret
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
new file mode 100755
index 000000000000..e2e477472844
--- /dev/null
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+#
+# Run a herd test and check the result against a "Result:" comment within
+# the litmus test.  If the verification result does not match that specified
+# in the litmus test, this script prints an error message prefixed with
+# "^^^" and exits with a non-zero status.  It also outputs verification
+# results to a file whose name is that of the specified litmus test, but
+# with ".out" appended.
+#
+# Usage:
+#	sh checklitmus.sh file.litmus
+#
+# The LINUX_HERD_OPTIONS environment variable may be used to specify
+# arguments to herd, which default to "-conf linux-kernel.cfg".  Thus,
+# one would normally run this in the directory containing the memory model,
+# specifying the pathname of the litmus test to check.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, you can access it online at
+# http://www.gnu.org/licenses/gpl-2.0.html.
+#
+# Copyright IBM Corporation, 2018
+#
+# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+
+litmus=$1
+herdoptions=${LINUX_HERD_OPTIONS--conf linux-kernel.cfg}
+
+if test -f "$litmus" -a -r "$litmus"
+then
+	:
+else
+	echo ' --- ' error: \"$litmus\" is not a readable file
+	exit 255
+fi
+if grep -q '^ \* Result: ' $litmus
+then
+	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
+else
+	outcome=specified
+fi
+
+echo Herd options: $herdoptions > $litmus.out
+/usr/bin/time herd7 -o ~/tmp $herdoptions $litmus >> $litmus.out 2>&1
+grep "Herd options:" $litmus.out
+grep '^Observation' $litmus.out
+if grep -q '^Observation' $litmus.out
+then
+	:
+else
+	cat $litmus.out
+	echo ' ^^^ Verification error'
+	echo ' ^^^ Verification error' >> $litmus.out 2>&1
+	exit 255
+fi
+if test "$outcome" = DEADLOCK
+then
+	echo grep 3 and 4
+	if grep '^Observation' $litmus.out | grep -q 'Never 0 0$'
+	then
+		ret=0
+	else
+		echo " ^^^ Unexpected non-$outcome verification"
+		echo " ^^^ Unexpected non-$outcome verification" >> $litmus.out 2>&1
+		ret=1
+	fi
+elif grep '^Observation' $litmus.out | grep -q $outcome || test "$outcome" = Maybe
+then
+	ret=0
+else
+	echo " ^^^ Unexpected non-$outcome verification"
+	echo " ^^^ Unexpected non-$outcome verification" >> $litmus.out 2>&1
+	ret=1
+fi
+tail -2 $litmus.out | head -1
+exit $ret
-- 
2.5.2
