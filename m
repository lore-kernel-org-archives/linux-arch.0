From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Subject: [tip:core/locking] Documentation/memory-barriers.txt:
  Add long atomic examples to memory-barriers.txt
Date: Mon, 16 Dec 2013 02:39:45 -0800
Message-ID: <tip-fb2b581968db140586e8d7db38ff278f60872313@git.kernel.org>
References: <1386799151-2219-2-git-send-email-paulmck@linux.vnet.ibm.com>
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
	  a.p.zijlstra@chello.nl, torvalds@linux-foundation.org,
	  paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
	  josh@joshtriplett.org, tglx@linutronix.de,
	  linux-arch@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386799151-2219-2-git-send-email-paulmck@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org, a.p.zijlstra@chello.nl, paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org, tglx@linutronix.de, josh@joshtriplett.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Commit-ID:  fb2b581968db140586e8d7db38ff278f60872313
Gitweb:     http://git.kernel.org/tip/fb2b581968db140586e8d7db38ff278f60872313
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Wed, 11 Dec 2013 13:59:05 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Dec 2013 11:36:09 +0100

Documentation/memory-barriers.txt: Add long atomic examples to memory-barriers.txt

Although the atomic_long_t functions are quite useful, they are
a bit obscure.  This commit therefore adds the common ones
alongside their atomic_t counterparts in
Documentation/memory-barriers.txt.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Reviewed-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: <linux-arch@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/1386799151-2219-2-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/memory-barriers.txt | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1d06723..2d22da0 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1728,21 +1728,23 @@ explicit lock operations, described later).  These include:
 
 	xchg();
 	cmpxchg();
-	atomic_xchg();
-	atomic_cmpxchg();
-	atomic_inc_return();
-	atomic_dec_return();
-	atomic_add_return();
-	atomic_sub_return();
-	atomic_inc_and_test();
-	atomic_dec_and_test();
-	atomic_sub_and_test();
-	atomic_add_negative();
-	atomic_add_unless();	/* when succeeds (returns 1) */
+	atomic_xchg();			atomic_long_xchg();
+	atomic_cmpxchg();		atomic_long_cmpxchg();
+	atomic_inc_return();		atomic_long_inc_return();
+	atomic_dec_return();		atomic_long_dec_return();
+	atomic_add_return();		atomic_long_add_return();
+	atomic_sub_return();		atomic_long_sub_return();
+	atomic_inc_and_test();		atomic_long_inc_and_test();
+	atomic_dec_and_test();		atomic_long_dec_and_test();
+	atomic_sub_and_test();		atomic_long_sub_and_test();
+	atomic_add_negative();		atomic_long_add_negative();
 	test_and_set_bit();
 	test_and_clear_bit();
 	test_and_change_bit();
 
+	/* when succeeds (returns 1) */
+	atomic_add_unless();		atomic_long_add_unless();
+
 These are used for such things as implementing LOCK-class and UNLOCK-class
 operations and adjusting reference counters towards object destruction, and as
 such the implicit memory barrier effects are necessary.
