Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62365 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754646AbbHCRDa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2015 13:03:30 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 4/8] lockref: remove homebrew cmpxchg64_relaxed macro definition
Date: Mon,  3 Aug 2015 18:02:27 +0100
Message-ID: <1438621351-15912-5-git-send-email-will.deacon@arm.com>
In-Reply-To: <1438621351-15912-1-git-send-email-will.deacon@arm.com>
References: <1438621351-15912-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org, Will Deacon <will.deacon@arm.com>
Message-ID: <20150803170227.QyfAzJvINL6tXdsgvjXAqybMKSarUXilpdV3fYXnfvE@z>

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

