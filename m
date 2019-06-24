Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFrm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 01:47:42 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/5] powerpc: don't use asm-generic/ptrace.h
Date: Mon, 24 Jun 2019 07:47:25 +0200
Message-ID: <20190624054728.30966-3-hch@lst.de>
In-Reply-To: <20190624054728.30966-1-hch@lst.de>
References: <20190624054728.30966-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190624054725.QYS3gX-9LDNJTmOnCwuJqzosGUjQjx3kuggdbvxeKz4@z>

Doing the indirection through macros for the regs accessors just
makes them harder to read, so implement the helpers directly.

Note that only the helpers actually used are implemented now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/ptrace.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index faa5a338ac5a..feee1b21bbd5 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -111,18 +111,33 @@ struct pt_regs
 
 #ifndef __ASSEMBLY__
 
-#define GET_IP(regs)		((regs)->nip)
-#define GET_USP(regs)		((regs)->gpr[1])
-#define GET_FP(regs)		(0)
-#define SET_FP(regs, val)
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->nip;
+}
+
+static inline void instruction_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->nip = val;
+}
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->gpr[1];
+}
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return 0;
+}
 
 #ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
-#define profile_pc profile_pc
+#else
+#define profile_pc(regs) instruction_pointer(regs)
 #endif
 
-#include <asm-generic/ptrace.h>
-
 #define kernel_stack_pointer(regs) ((regs)->gpr[1])
 static inline int is_syscall_success(struct pt_regs *regs)
 {
-- 
2.20.1
