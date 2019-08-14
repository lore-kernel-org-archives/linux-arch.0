From: Akira Yokosawa <akiyks@gmail.com>
Subject: Subject: [PATCH 1/2] tools/memory-model: Reflect updated file name
 convention in judgelitmus.sh
Date: Thu, 15 Aug 2019 00:13:57 +0900
Message-ID: <1dbd392a-876c-1d6b-f718-76a37f1d55ee@gmail.com>
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

From 6251ebb775a81f1ac158f197ad8110b8f98c4248 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Wed, 14 Aug 2019 17:20:54 +0900
Subject: [PATCH 1/2] tools/memory-model: Reflect updated file name convention in judgelitmus.sh

Commit ("tools/memory-model: Move from .AArch64.litmus.out to
.litmus.AArch.out") swapped "HW" and "litmus" part in .out file name.
Reflect the change in header comment in judgelitmus.sh

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 6408c012bdf5..c91130814593 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -6,7 +6,7 @@
 # test ran correctly.  If the --hw argument is omitted, check against the
 # LKMM output, which is assumed to be in file.litmus.out.  If this argument
 # is provided, this is assumed to be a hardware test, and the output is
-# assumed to be in file.HW.litmus.out, where "HW" is the --hw argument.
+# assumed to be in file.litmus.HW.out, where "HW" is the --hw argument.
 # In addition, non-Sometimes verification results will be noted, but
 # forgiven.  Furthermore, if there is no "Result:" comment but there is
 # an LKMM .litmus.out file, the observation in that file will be used
-- 
2.17.1
