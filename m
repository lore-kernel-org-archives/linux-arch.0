From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 4/8] lockref: remove homebrew cmpxchg64_relaxed macro definition
Date: Fri, 24 Jul 2015 15:04:37 +0100
Message-ID: <1437746681-2809-5-git-send-email-will.deacon@arm.com>
References: <1437746681-2809-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437746681-2809-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

cmpxchg64_relaxed is now defined by linux/atomic.h, so we can
remove our local definition from the lockref code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 lib/lockref.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/lockref.c b/lib/lockref.c
index 494994bf17c8..5a92189ad711 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -4,14 +4,6 @@
 #if USE_CMPXCHG_LOCKREF
 
 /*
- * Allow weakly-ordered memory architectures to provide barrier-less
- * cmpxchg semantics for lockref updates.
- */
-#ifndef cmpxchg64_relaxed
-# define cmpxchg64_relaxed cmpxchg64
-#endif
-
-/*
  * Note that the "cmpxchg()" reloads the "old" value for the
  * failure case.
  */
-- 
2.1.4
