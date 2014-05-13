Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0118.outbound.protection.outlook.com ([207.46.100.118]:4245
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759765AbaEMJDm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:03:42 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 09/25] hexagon: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:03:29 +0800
Message-ID: <1399971809-4300-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org
Message-ID: <20140513090329.h8wE0D2IxGjz2VOj4scn0Z0bomKh56lcNg_Y6GzZqik@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/hexagon/include/asm/Kbuild             |  1 -
 arch/hexagon/include/uapi/asm/Kbuild        |  1 +
 arch/hexagon/include/uapi/asm/posix_types.h | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/hexagon/include/uapi/asm/posix_types.h

diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 0e69796..fbceaf8 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -33,7 +33,6 @@ generic-y += msgbuf.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += rwsem.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index c31706c..336a2d0 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -5,6 +5,7 @@ header-y += bitsperlong.h
 header-y += byteorder.h
 header-y += kvm_para.h
 header-y += param.h
+header-y += posix_types.h
 header-y += ptrace.h
 header-y += registers.h
 header-y += setup.h
diff --git a/arch/hexagon/include/uapi/asm/posix_types.h b/arch/hexagon/include/uapi/asm/posix_types.h
new file mode 100644
index 0000000..01e6b1c
--- /dev/null
+++ b/arch/hexagon/include/uapi/asm/posix_types.h
@@ -0,0 +1,17 @@
+#ifndef __ARCH_HEXAGON_POSIX_TYPES_H
+#define __ARCH_HEXAGON_POSIX_TYPES_H
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

