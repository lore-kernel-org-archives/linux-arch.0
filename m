From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 10/14] hppa: locks: remove redundant arch_*_relax operations
Date: Tue, 12 Nov 2013 16:47:48 +0000
Message-ID: <1384274872-26849-10-git-send-email-will.deacon@arm.com>
References: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40248 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753484Ab3KLQsR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Nov 2013 11:48:17 -0500
In-Reply-To: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Helge Deller <deller@gmx.de>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for parisc.

Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/parisc/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/parisc/include/asm/spinlock.h b/arch/parisc/include/asm/spinlock.h
index 3516e0b27044..64f2992e439f 100644
--- a/arch/parisc/include/asm/spinlock.h
+++ b/arch/parisc/include/asm/spinlock.h
@@ -191,8 +191,4 @@ static __inline__ int arch_write_can_lock(arch_rwlock_t *rw)
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SPINLOCK_H */
-- 
1.8.2.2
