From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 01/25] arch: add __SYSCALL_DEFINE_ARCH
Date: Mon, 30 Mar 2020 23:45:33 +0900
Message-ID: <9b9d47a8be1c38561d0fc3e4478628e4bb6056ef.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51364 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgC3Oqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:46:34 -0400
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

This allows the architecture code to process the system call
definitions. It is used by LKL to create strong typed function
definitions for system calls.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Cc: linux-api@vger.kernel.org
---
 include/linux/syscalls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..e45815a3ee10 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -203,9 +203,14 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 }
 #endif
 
+#ifndef __SYSCALL_DEFINE_ARCH
+#define __SYSCALL_DEFINE_ARCH(x, sname, ...)
+#endif
+
 #ifndef SYSCALL_DEFINE0
 #define SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
+	__SYSCALL_DEFINE_ARCH(0, _##sname);			\
 	asmlinkage long sys_##sname(void);			\
 	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
 	asmlinkage long sys_##sname(void)
@@ -222,6 +227,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 
 #define SYSCALL_DEFINEx(x, sname, ...)				\
 	SYSCALL_METADATA(sname, x, __VA_ARGS__)			\
+	__SYSCALL_DEFINE_ARCH(x, sname, __VA_ARGS__)		\
 	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
 
 #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
-- 
2.21.0 (Apple Git-122.2)
