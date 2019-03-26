Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZIWv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 04:22:51 -0400
From: guoren@kernel.org
Subject: [PATCH] csky: Add non-uapi asm/ptrace.h namespace
Date: Tue, 26 Mar 2019 16:22:31 +0800
Message-ID: <1553588551-30020-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, ldv@altlinux.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com, strace-devel@lists.strace.io
Message-ID: <20190326082231.mirwH3W_Na_EZgi1DlDusOXRxCKz9L6EX_ek2i_juwE@z>

From: Guo Ren <ren_guo@c-sky.com>

Move #ifdef __KERNEL__ code in the uapi namespace to non-uapi
include/asm/ptrace.h namespace and remove #ifdef __KERNEL__ in
include/asm/ptrace.h. Seperate ptrace.h in uapi and non-uapi is more
common and clear.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/csky/include/asm/ptrace.h      | 29 +++++++++++++++++++++++++++++
 arch/csky/include/uapi/asm/ptrace.h | 20 --------------------
 2 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 arch/csky/include/asm/ptrace.h

diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
new file mode 100644
index 0000000..1e00578
--- /dev/null
+++ b/arch/csky/include/asm/ptrace.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_PTRACE_H
+#define __ASM_CSKY_PTRACE_H
+
+#include <uapi/asm/ptrace.h>
+
+#ifndef __ASSEMBLY__
+
+#define PS_S	0x80000000 /* Supervisor Mode */
+
+#define arch_has_single_step() (1)
+#define current_pt_regs() \
+({ (struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) - 1; })
+
+#define user_stack_pointer(regs) ((regs)->usp)
+
+#define user_mode(regs) (!((regs)->sr & PS_S))
+#define instruction_pointer(regs) ((regs)->pc)
+#define profile_pc(regs) instruction_pointer(regs)
+
+static inline unsigned long regs_return_value(struct pt_regs *regs)
+{
+	return regs->a0;
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_CSKY_PTRACE_H */
diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
index 9bf5b1a..4e248d5 100644
--- a/arch/csky/include/uapi/asm/ptrace.h
+++ b/arch/csky/include/uapi/asm/ptrace.h
@@ -48,25 +48,5 @@ struct user_fp {
 	unsigned long	reserved;
 };
 
-#ifdef __KERNEL__
-
-#define PS_S	0x80000000 /* Supervisor Mode */
-
-#define arch_has_single_step() (1)
-#define current_pt_regs() \
-({ (struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) - 1; })
-
-#define user_stack_pointer(regs) ((regs)->usp)
-
-#define user_mode(regs) (!((regs)->sr & PS_S))
-#define instruction_pointer(regs) ((regs)->pc)
-#define profile_pc(regs) instruction_pointer(regs)
-
-static inline unsigned long regs_return_value(struct pt_regs *regs)
-{
-	return regs->a0;
-}
-
-#endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _CSKY_PTRACE_H */
-- 
2.7.4
