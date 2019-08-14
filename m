From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 2/2] tools/memory-model: Mention data-race capability in
 jugdelitmus.sh's header
Date: Thu, 15 Aug 2019 00:16:28 +0900
Message-ID: <a94b590d-5683-932d-5354-b77b91e7af4b@gmail.com>
References: <20190801222026.GA11315@linux.ibm.com>
 <20190801222056.12144-27-paulmck@linux.ibm.com>
 <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
 <20190812180649.GM28441@linux.ibm.com>
 <277937a7-0f50-ec1c-09ec-95ffbf85541e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <277937a7-0f50-ec1c-09ec-95ffbf85541e@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Peter Zijlstra <peterz@infradead.org>, Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>
List-Id: linux-arch.vger.kernel.org

From 67092cb93f7a0fd3c4f9a300637e4f5c61fc944a Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Wed, 14 Aug 2019 17:48:25 +0900
Subject: [PATCH 2/2] tools/memory-model: Mention data-race capability in jugdelitmus.sh's header

Replicate description of data-race capability from the change log of
commit ("tools/memory-model: Add data-race capabilities to
judgelitmus.sh") in the header comment.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index c91130814593..1ec5d89fcfbb 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -4,13 +4,19 @@
 # Given a .litmus test and the corresponding litmus output file, check
 # the .litmus.out file against the "Result:" comment to judge whether the
 # test ran correctly.  If the --hw argument is omitted, check against the
-# LKMM output, which is assumed to be in file.litmus.out.  If this argument
-# is provided, this is assumed to be a hardware test, and the output is
-# assumed to be in file.litmus.HW.out, where "HW" is the --hw argument.
-# In addition, non-Sometimes verification results will be noted, but
-# forgiven.  Furthermore, if there is no "Result:" comment but there is
-# an LKMM .litmus.out file, the observation in that file will be used
-# to judge the assembly-language verification.
+# LKMM output, which is assumed to be in file.litmus.out. If either a
+# "DATARACE" marker in the "Result:" comment or a "Flag data-race" marker
+# in the LKMM output is present, the other must also be as well, at least
+# for litmus tests having a "Result:" comment. In this case, a failure of
+# the Always/Sometimes/Never portion of the "Result:" prediction will be
+# noted, but forgiven.
+#
+# If the --hw argument is provided, this is assumed to be a hardware
+# test, and the output is assumed to be in file.litmus.HW.out, where
+# "HW" is the --hw argument. In addition, non-Sometimes verification
+# results will be noted, but forgiven.  Furthermore, if there is no
+# "Result:" comment but there is an LKMM .litmus.out file, the observation
+# in that file will be used to judge the assembly-language verification.
 #
 # Usage:
 #	judgelitmus.sh file.litmus
-- 
2.17.1
