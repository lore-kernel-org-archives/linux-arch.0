Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0116.outbound.protection.outlook.com ([207.46.100.116]:48954
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932714AbaEMJGy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:06:54 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 23/25] unicore32: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:06:44 +0800
Message-ID: <1399972004-4818-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20140513090644.k3BXs8PLtInxULy0bftUj9bF68Uu32Nhhe-9qQY4ImM@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/unicore32/include/asm/Kbuild             |  1 -
 arch/unicore32/include/uapi/asm/Kbuild        |  1 +
 arch/unicore32/include/uapi/asm/posix_types.h | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/unicore32/include/uapi/asm/posix_types.h

diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 1e5fb87..9742390 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -33,7 +33,6 @@ generic-y += param.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += scatterlist.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 0514d7a..3eeb84a 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 header-y += byteorder.h
 header-y += kvm_para.h
+header-y += posix_types.h
 header-y += ptrace.h
 header-y += sigcontext.h
 header-y += unistd.h
diff --git a/arch/unicore32/include/uapi/asm/posix_types.h b/arch/unicore32/include/uapi/asm/posix_types.h
new file mode 100644
index 0000000..3c9dd54
--- /dev/null
+++ b/arch/unicore32/include/uapi/asm/posix_types.h
@@ -0,0 +1,17 @@
+#ifndef __ARCH_UNICORE32_POSIX_TYPES_H
+#define __ARCH_UNICORE32_POSIX_TYPES_H
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

