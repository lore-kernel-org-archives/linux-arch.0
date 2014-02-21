From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH RESEND 07/14] m32r: locks: remove redundant arch_*_relax operations
Date: Fri, 21 Feb 2014 17:34:54 +0000
Message-ID: <1393004101-25382-8-git-send-email-will.deacon@arm.com>
References: <1393004101-25382-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44764 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933429AbaBURfZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Feb 2014 12:35:25 -0500
In-Reply-To: <1393004101-25382-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Hirokazu Takata <takata@linux-m32r.org>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for m32r.

Cc: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/m32r/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/m32r/include/asm/spinlock.h b/arch/m32r/include/asm/spinlock.h
index fa13694eaae3..3112249ebee4 100644
--- a/arch/m32r/include/asm/spinlock.h
+++ b/arch/m32r/include/asm/spinlock.h
@@ -320,8 +320,4 @@ static inline int arch_write_trylock(arch_rwlock_t *lock)
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif	/* _ASM_M32R_SPINLOCK_H */
-- 
1.8.2.2
