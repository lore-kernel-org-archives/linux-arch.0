From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 09/14] mips: locks: remove redundant arch_*_relax operations
Date: Tue, 17 Sep 2013 16:07:41 +0100
Message-ID: <1379430466-30520-10-git-send-email-will.deacon@arm.com>
References: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41238 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752751Ab3IQPIA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Sep 2013 11:08:00 -0400
In-Reply-To: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for MIPS.

Cc: Ralf Baechle <ralf@linux-mips.org>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/mips/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 78d201f..7bd850a 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -419,8 +419,4 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* _ASM_SPINLOCK_H */
-- 
1.8.2.2
