From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 21/25] sh: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:06:30 +0800
Message-ID: <1399971990-4744-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/sh/include/uapi/asm/posix_types_32.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/include/uapi/asm/posix_types_32.h b/arch/sh/include/uapi/asm/posix_types_32.h
index ba0bdc4..cfc4331 100644
--- a/arch/sh/include/uapi/asm/posix_types_32.h
+++ b/arch/sh/include/uapi/asm/posix_types_32.h
@@ -17,6 +17,12 @@ typedef unsigned short	__kernel_old_gid_t;
 typedef unsigned short	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* __ASM_SH_POSIX_TYPES_32_H */
-- 
1.8.2.1
