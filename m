From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH RESEND 04/14] blackfin: locks: remove redundant arch_*_relax operations
Date: Fri, 21 Feb 2014 17:34:51 +0000
Message-ID: <1393004101-25382-5-git-send-email-will.deacon@arm.com>
References: <1393004101-25382-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44763 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933429AbaBURfR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Feb 2014 12:35:17 -0500
In-Reply-To: <1393004101-25382-1-git-send-email-will.deacon@arm.com>
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
