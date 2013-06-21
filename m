From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 05/16] blackfin: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:26 +0100
Message-ID: <1371835057-19335-6-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49349 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423424Ab3FURRy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:54 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mike Frysinger <vapier@gentoo.org>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for Blackfin.

Cc: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/blackfin/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/blackfin/include/asm/spinlock.h b/arch/blackfin/include/asm/spinlock.h
index 490c7ca..8c58dda 100644
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
