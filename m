From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH RESEND 05/14] cris: locks: remove redundant arch_*_relax operations
Date: Fri, 21 Feb 2014 17:34:52 +0000
Message-ID: <1393004101-25382-6-git-send-email-will.deacon@arm.com>
References: <1393004101-25382-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44751 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933387AbaBURfK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Feb 2014 12:35:10 -0500
In-Reply-To: <1393004101-25382-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for Cris.

Cc: Mikael Starvik <starvik@axis.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/cris/include/arch-v32/arch/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/cris/include/arch-v32/arch/spinlock.h b/arch/cris/include/arch-v32/arch/spinlock.h
index f13275522f4d..bf94cc6bd9b4 100644
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
