From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 06/16] cris: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:27 +0100
Message-ID: <1371835057-19335-7-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49337 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423388Ab3FURRr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:47 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for Cris.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/cris/include/arch-v32/arch/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/cris/include/arch-v32/arch/spinlock.h b/arch/cris/include/arch-v32/arch/spinlock.h
index f132755..bf94cc6 100644
--- a/arch/cris/include/arch-v32/arch/spinlock.h
+++ b/arch/cris/include/arch-v32/arch/spinlock.h
@@ -124,8 +124,4 @@ static  inline int arch_write_trylock(arch_rwlock_t *rw)
 #define _raw_read_lock_flags(lock, flags) _raw_read_lock(lock)
 #define _raw_write_lock_flags(lock, flags) _raw_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_ARCH_SPINLOCK_H */
-- 
1.8.2.2
