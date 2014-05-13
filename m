Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0130.outbound.protection.outlook.com ([207.46.100.130]:3699
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754763AbaEMJCs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:02:48 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 02/25] arc: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:02:36 +0800
Message-ID: <1399971756-4042-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Vineet Gupta <vgupta@synopsys.com>
Message-ID: <20140513090236.77_Z93m-8H6VPIsO0RGzuzTBB7PfnbFV3_rRj23Sozw@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/arc/include/asm/Kbuild             |  1 -
 arch/arc/include/uapi/asm/Kbuild        |  1 +
 arch/arc/include/uapi/asm/posix_types.h | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/include/uapi/asm/posix_types.h

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index e76fd79..2186afc 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -30,7 +30,6 @@ generic-y += parport.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += scatterlist.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 18fefae..1d6ffba 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -5,6 +5,7 @@ header-y += page.h
 header-y += setup.h
 header-y += byteorder.h
 header-y += cachectl.h
+header-y += posix_types.h
 header-y += ptrace.h
 header-y += sigcontext.h
 header-y += signal.h
diff --git a/arch/arc/include/uapi/asm/posix_types.h b/arch/arc/include/uapi/asm/posix_types.h
new file mode 100644
index 0000000..ac69105
--- /dev/null
+++ b/arch/arc/include/uapi/asm/posix_types.h
@@ -0,0 +1,17 @@
+#ifndef __ARCH_ARC_POSIX_TYPES_H
+#define __ARCH_ARC_POSIX_TYPES_H
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

