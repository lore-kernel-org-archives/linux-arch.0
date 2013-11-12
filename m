From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 06/14] ia64: locks: remove redundant arch_*_relax operations
Date: Tue, 12 Nov 2013 16:47:44 +0000
Message-ID: <1384274872-26849-6-git-send-email-will.deacon@arm.com>
References: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40243 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753494Ab3KLQsQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Nov 2013 11:48:16 -0500
In-Reply-To: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for Itanium.

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/ia64/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/ia64/include/asm/spinlock.h b/arch/ia64/include/asm/spinlock.h
index 45698cd15b7b..0110413d89c0 100644
--- a/arch/ia64/include/asm/spinlock.h
+++ b/arch/ia64/include/asm/spinlock.h
@@ -289,8 +289,4 @@ static inline int arch_read_trylock(arch_rwlock_t *x)
 	return (u32)ia64_cmpxchg4_acq((__u32 *)(x), new.word, old.word) == old.word;
 }
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /*  _ASM_IA64_SPINLOCK_H */
-- 
1.8.2.2
