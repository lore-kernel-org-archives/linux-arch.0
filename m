From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 03/14] arm64: locks: remove redundant arch_*_relax operations
Date: Tue, 17 Sep 2013 16:07:35 +0100
Message-ID: <1379430466-30520-4-git-send-email-will.deacon@arm.com>
References: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41204 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752826Ab3IQPH6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Sep 2013 11:07:58 -0400
In-Reply-To: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for arm64.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 0defa07..447a102 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -196,8 +196,4 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SPINLOCK_H */
-- 
1.8.2.2
