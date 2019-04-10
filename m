Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDJGOy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Apr 2019 02:14:54 -0400
From: guoren@kernel.org
Subject: [PATCH V2] csky: Add perf_arch_fetch_caller_regs support
Date: Wed, 10 Apr 2019 14:12:05 +0800
Message-ID: <1554876725-30455-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>
Message-ID: <20190410061205.q9PvtaK92EQXiQXc7yG45bbAo4epFYFERRNsob_i6Iw@z>

From: Mao Han <han_mao@c-sky.com>

In trace events as tracepoints context are not able to
be retrieve with task_pt_regs. Without arch caller regs
support the pt_regs context will be all zero, perf can
not parsing the callchain and resolving the symbols
correctly, some time will even get into deadlock
while handling the page fault, eg:

perf kmem —page record ls

Changelog
 - Add test case cmd in comment
 - Use regs_fp(regs) which is defined in abi/regdef.h

Signed-off-by: Mao Han <han_mao@c-sky.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/abiv1/inc/abi/regdef.h   | 1 +
 arch/csky/abiv2/inc/abi/regdef.h   | 1 +
 arch/csky/include/asm/perf_event.h | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
index 729b1c3..104707f 100644
--- a/arch/csky/abiv1/inc/abi/regdef.h
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -6,6 +6,7 @@
 
 #define syscallid	r1
 #define regs_syscallid(regs) regs->regs[9]
+#define regs_fp(regs) regs->regs[2]
 
 /*
  * PSR format:
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
index 77cb178..d7328bb 100644
--- a/arch/csky/abiv2/inc/abi/regdef.h
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -6,6 +6,7 @@
 
 #define syscallid	r7
 #define regs_syscallid(regs) regs->regs[3]
+#define regs_fp(regs) regs->regs[4]
 
 /*
  * PSR format:
diff --git a/arch/csky/include/asm/perf_event.h b/arch/csky/include/asm/perf_event.h
index ea81931..572093e 100644
--- a/arch/csky/include/asm/perf_event.h
+++ b/arch/csky/include/asm/perf_event.h
@@ -4,4 +4,12 @@
 #ifndef __ASM_CSKY_PERF_EVENT_H
 #define __ASM_CSKY_PERF_EVENT_H
 
+#include <abi/regdef.h>
+
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+	(regs)->pc = (__ip); \
+	regs_fp(regs) = (unsigned long) __builtin_frame_address(0); \
+	asm volatile("mov %0, sp\n":"=r"((regs)->usp)); \
+}
+
 #endif /* __ASM_PERF_EVENT_ELF_H */
-- 
2.7.4
