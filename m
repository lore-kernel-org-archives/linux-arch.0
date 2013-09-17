From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 12/14] sh: locks: remove redundant arch_*_relax operations
Date: Tue, 17 Sep 2013 16:07:44 +0100
Message-ID: <1379430466-30520-13-git-send-email-will.deacon@arm.com>
References: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41243 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752893Ab3IQPIE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Sep 2013 11:08:04 -0400
In-Reply-To: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for SuperH.

Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/sh/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sh/include/asm/spinlock.h b/arch/sh/include/asm/spinlock.h
index bdc0f3b..a89820d 100644
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
