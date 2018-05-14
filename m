From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 8/8] atomic_ops.rst: Use `warning` rst directive
Date: Mon, 14 May 2018 15:55:33 -0700
Message-ID: <1526338533-6044-8-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514225457.GA5142@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514225457.GA5142@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, SeongJae Park <sj38.park@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: SeongJae Park <sj38.park@gmail.com>

One warning message in 'atomic_ops.rst' is not using 'warning' rst
directive while others does.  This commit modifies the message to use
'warning' rst directive.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/core-api/atomic_ops.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index 4ea4af71e68a..2e7165f86f55 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -466,10 +466,12 @@ Like the above, except that these routines return a boolean which
 indicates whether the changed bit was set _BEFORE_ the atomic bit
 operation.
 
-WARNING! It is incredibly important that the value be a boolean,
-ie. "0" or "1".  Do not try to be fancy and save a few instructions by
-declaring the above to return "long" and just returning something like
-"old_val & mask" because that will not work.
+
+.. warning::
+        It is incredibly important that the value be a boolean, ie. "0" or "1".
+        Do not try to be fancy and save a few instructions by declaring the
+        above to return "long" and just returning something like "old_val &
+        mask" because that will not work.
 
 For one thing, this return value gets truncated to int in many code
 paths using these interfaces, so on 64-bit if the bit is set in the
-- 
2.5.2
