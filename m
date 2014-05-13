Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0142.outbound.protection.outlook.com ([207.46.100.142]:63798
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932593AbaEMJGK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:06:10 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 16/25] openrisc: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:05:58 +0800
Message-ID: <1399971958-4561-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net
Message-ID: <20140513090558.eSZTGFDmwfzLZxgNMH7zYvx0PLOgppQq2ZQBjvmp228@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/openrisc/include/asm/Kbuild             |  1 -
 arch/openrisc/include/uapi/asm/Kbuild        |  1 +
 arch/openrisc/include/uapi/asm/posix_types.h | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/uapi/asm/posix_types.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 480af0d..3da7847 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -42,7 +42,6 @@ generic-y += msgbuf.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += scatterlist.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 80761eb..c09b436 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -5,6 +5,7 @@ header-y += byteorder.h
 header-y += elf.h
 header-y += kvm_para.h
 header-y += param.h
+header-y += posix_types.h
 header-y += ptrace.h
 header-y += sigcontext.h
 header-y += unistd.h
diff --git a/arch/openrisc/include/uapi/asm/posix_types.h b/arch/openrisc/include/uapi/asm/posix_types.h
new file mode 100644
index 0000000..5ccf37d
--- /dev/null
+++ b/arch/openrisc/include/uapi/asm/posix_types.h
@@ -0,0 +1,17 @@
+#ifndef __ARCH_OPENRISC_POSIX_TYPES_H
+#define __ARCH_OPENRISC_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc. Also, we cannot
+ * assume GCC is being used.
+ */
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
+#include <asm-generic/posix_types.h>
+
+#endif
-- 
1.8.2.1

