Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37931 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935132AbcAUK30 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Jan 2016 05:29:26 -0500
Date: Thu, 21 Jan 2016 12:29:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] sh: fix smp_store_mb for !SMP
Message-ID: <1453371795-32669-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, virtualization@lists.linux-foundation.org
Message-ID: <20160121102922.xFzLTTcAsJxZ7ci_xdgPifkni83ODI1Oxm5SjJORH3g@z>

sh variant of smp_store_mb() calls xchg() on !SMP which is stronger than
implied by both the name and the documentation.

commit 90a3ccb0be538a914e6a5c51ae919762261563ad ("sh: define __smp_xxx,
fix smp_store_mb for !SMP") was supposed to fix it but
left the bug in place.

Drop smp_store_mb, so that code in asm-generic/barrier.h
will define it correctly depending on CONFIG_SMP.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I put this in my tree as that's where the original commit
came through, but if anyone else prefers to merge it, pls
let me know.

 arch/sh/include/asm/barrier.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/include/asm/barrier.h b/arch/sh/include/asm/barrier.h
index f887c64..8a84e05 100644
--- a/arch/sh/include/asm/barrier.h
+++ b/arch/sh/include/asm/barrier.h
@@ -33,7 +33,6 @@
 #endif
 
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
-#define smp_store_mb(var, value) __smp_store_mb(var, value)
 
 #include <asm-generic/barrier.h>
 
-- 
MST
