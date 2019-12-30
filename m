Return-Path: <SRS0=aRn0=2U=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfL3IX7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Dec 2019 03:23:59 -0500
From: guoren@kernel.org
Subject: [PATCH 2/5] csky: Initial stack protector support
Date: Mon, 30 Dec 2019 16:23:28 +0800
Message-ID: <20191230082331.30976-2-guoren@kernel.org>
In-Reply-To: <20191230082331.30976-1-guoren@kernel.org>
References: <20191230082331.30976-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>
Message-ID: <20191230082328.4YS55YfGP5rjNLZ0H0wh7ZREVwGmnhEpah7jO5yIcug@z>

From: Mao Han <han_mao@c-sky.com>

This is a basic -fstack-protector support without per-task canary
switching. The protector will report something like when stack
corruption is detected:

It's tested with strcpy local array overflow in sys_kill and get:
stack-protector: Kernel stack is corrupted in: sys_kill+0x23c/0x23c

TODO:
 - Support task switch for different cannary

Signed-off-by: Mao Han <han_mao@c-sky.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/Kconfig                      |  1 +
 arch/csky/include/asm/stackprotector.h | 29 ++++++++++++++++++++++++++
 arch/csky/kernel/process.c             |  6 ++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/csky/include/asm/stackprotector.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3973847b5f42..285234300740 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
+	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
diff --git a/arch/csky/include/asm/stackprotector.h b/arch/csky/include/asm/stackprotector.h
new file mode 100644
index 000000000000..d7cd4e51edd9
--- /dev/null
+++ b/arch/csky/include/asm/stackprotector.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H 1
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif /* __ASM_SH_STACKPROTECTOR_H */
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f320d9248a22..5349cd8c0f30 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -16,6 +16,12 @@
 
 struct cpuinfo_csky cpu_data[NR_CPUS];
 
+#ifdef CONFIG_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
-- 
2.17.0
