From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 16/16] x86: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:37 +0100
Message-ID: <1371835057-19335-17-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49347 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423441Ab3FURRv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:51 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for x86.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/x86/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 33692ea..1088d8d 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -229,10 +229,6 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 #undef WRITE_LOCK_SUB
 #undef WRITE_LOCK_CMP
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 /* The {read|write|spin}_lock() on x86 are full memory barriers. */
 static inline void smp_mb__after_lock(void) { }
 #define ARCH_HAS_SMP_MB_AFTER_LOCK
-- 
1.8.2.2
