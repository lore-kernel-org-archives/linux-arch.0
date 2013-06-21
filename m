From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 13/16] s390: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:34 +0100
Message-ID: <1371835057-19335-14-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49328 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423327Ab3FURRq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:46 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

The arch_{read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for S390. arch_spin_relax is
left alone, since the S390 spinlock internals rely on (and export) this
symbol.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/s390/include/asm/spinlock.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index 701fe8c..8b030e2 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -170,7 +170,4 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 	return _raw_write_trylock_retry(rw);
 }
 
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SPINLOCK_H */
-- 
1.8.2.2
