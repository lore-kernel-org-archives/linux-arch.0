Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:40298
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759686AbaEMJDL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:03:11 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 06/25] c6x: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:03:01 +0800
Message-ID: <1399971781-4190-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org
Message-ID: <20140513090301.l2_7Eu7KJrib9bGX33lIU-b0Ki2fzOg6F1POIn5PpAw@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/c6x/include/asm/Kbuild             |  1 -
 arch/c6x/include/uapi/asm/Kbuild        |  1 +
 arch/c6x/include/uapi/asm/posix_types.h | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/c6x/include/uapi/asm/posix_types.h

diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 8dbdce8..cf7bd2e 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -35,7 +35,6 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += pgalloc.h
 generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += scatterlist.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index e9bc2b2..7435d6c 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += kvm_para.h
 
 header-y += byteorder.h
 header-y += kvm_para.h
+header-y += posix_types.h
 header-y += ptrace.h
 header-y += setup.h
 header-y += sigcontext.h
diff --git a/arch/c6x/include/uapi/asm/posix_types.h b/arch/c6x/include/uapi/asm/posix_types.h
new file mode 100644
index 0000000..dbad459
--- /dev/null
+++ b/arch/c6x/include/uapi/asm/posix_types.h
@@ -0,0 +1,17 @@
+#ifndef __ARCH_C6X_POSIX_TYPES_H
+#define __ARCH_C6X_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc. Also, we cannot
+ * assume GCC is being used.
+ */
+typedef long		__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long		__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
+#include <asm-generic/posix_types.h>
+
+#endif
-- 
1.8.2.1

