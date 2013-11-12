From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 12/14] sh: locks: remove redundant arch_*_relax operations
Date: Tue, 12 Nov 2013 16:47:50 +0000
Message-ID: <1384274872-26849-12-git-send-email-will.deacon@arm.com>
References: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40254 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754138Ab3KLQsU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Nov 2013 11:48:20 -0500
In-Reply-To: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for SuperH.

Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/sh/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sh/include/asm/spinlock.h b/arch/sh/include/asm/spinlock.h
index bdc0f3b6c56a..a89820dc6d9e 100644
--- a/arch/sh/include/asm/spinlock.h
+++ b/arch/sh/include/asm/spinlock.h
@@ -219,8 +219,4 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SH_SPINLOCK_H */
-- 
1.8.2.2
