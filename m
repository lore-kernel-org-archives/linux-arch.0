From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 07/16] ia64: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:28 +0100
Message-ID: <1371835057-19335-8-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49350 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423453Ab3FURRy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:54 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for Itanium.

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/ia64/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/ia64/include/asm/spinlock.h b/arch/ia64/include/asm/spinlock.h
index 54ff557..041f2bc 100644
--- a/arch/ia64/include/asm/spinlock.h
+++ b/arch/ia64/include/asm/spinlock.h
@@ -284,8 +284,4 @@ static inline int arch_read_trylock(arch_rwlock_t *x)
 	return (u32)ia64_cmpxchg4_acq((__u32 *)(x), new.word, old.word) == old.word;
 }
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /*  _ASM_IA64_SPINLOCK_H */
-- 
1.8.2.2
