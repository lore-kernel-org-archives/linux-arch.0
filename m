Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39839 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752203AbbGPPdM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jul 2015 11:33:12 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 4/7] lockref: remove homebrew cmpxchg64_relaxed macro definition
Date: Thu, 16 Jul 2015 16:32:35 +0100
Message-ID: <1437060758-10381-5-git-send-email-will.deacon@arm.com>
In-Reply-To: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20150716153235.5vl6NmNGN1PQaVMPzUkbPHAoF9_F8ddTw_dljR0z6MI@z>

cmpxchg64_relaxed is now defined by asm-generic/atomic.h, so we can
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

