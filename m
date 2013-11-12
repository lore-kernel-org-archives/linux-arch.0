From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 04/14] blackfin: locks: remove redundant arch_*_relax operations
Date: Tue, 12 Nov 2013 16:47:42 +0000
Message-ID: <1384274872-26849-4-git-send-email-will.deacon@arm.com>
References: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40252 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753728Ab3KLQsU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Nov 2013 11:48:20 -0500
In-Reply-To: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mike Frysinger <vapier@gentoo.org>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for Blackfin.

Cc: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/blackfin/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/blackfin/include/asm/spinlock.h b/arch/blackfin/include/asm/spinlock.h
index 490c7caa02d9..8c58ddaec369 100644
--- a/arch/blackfin/include/asm/spinlock.h
+++ b/arch/blackfin/include/asm/spinlock.h
@@ -96,10 +96,6 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 	__raw_write_unlock_asm(&rw->lock);
 }
 
-#define arch_spin_relax(lock)  	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif
 
 #endif /*  !__BFIN_SPINLOCK_H */
-- 
1.8.2.2
