Return-Path: <SRS0=oaWr=BD=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGXNPN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 09:15:13 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v4 6/6] powerpc: implement smp_cond_load_relaxed
Date: Fri, 24 Jul 2020 23:14:23 +1000
Message-ID: <20200724131423.1362108-7-npiggin@gmail.com>
In-Reply-To: <20200724131423.1362108-1-npiggin@gmail.com>
References: <20200724131423.1362108-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200724131423.vLgRNufidJDEIKTXl1Kqf-C6LTg1uGhzjIc3taEct2s@z>

This implements smp_cond_load_relaed with the slowpath busy loop using the
preferred SMT priority pattern.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/barrier.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 123adcefd40f..9b4671d38674 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,6 +76,20 @@ do {									\
 	___p1;								\
 })
 
+#define smp_cond_load_relaxed(ptr, cond_expr) ({		\
+	typeof(ptr) __PTR = (ptr);				\
+	__unqual_scalar_typeof(*ptr) VAL;			\
+	VAL = READ_ONCE(*__PTR);				\
+	if (unlikely(!(cond_expr))) {				\
+		spin_begin();					\
+		do {						\
+			VAL = READ_ONCE(*__PTR);		\
+		} while (!(cond_expr));				\
+		spin_end();					\
+	}							\
+	(typeof(*ptr))VAL;					\
+})
+
 #ifdef CONFIG_PPC_BOOK3S_64
 #define NOSPEC_BARRIER_SLOT   nop
 #elif defined(CONFIG_PPC_FSL_BOOK3E)
-- 
2.23.0
