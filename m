From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 10/25] m32r: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:03:37 +0800
Message-ID: <1399971817-4337-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Hirokazu Takata <takata@linux-m32r.org>, linux-m32r@ml.linux-m32r.org
List-Id: linux-arch.vger.kernel.org

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/m32r/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/m32r/include/uapi/asm/posix_types.h b/arch/m32r/include/uapi/asm/posix_types.h
index 236de26..77cf049 100644
--- a/arch/m32r/include/uapi/asm/posix_types.h
+++ b/arch/m32r/include/uapi/asm/posix_types.h
@@ -20,6 +20,12 @@ typedef unsigned short	__kernel_gid_t;
 typedef unsigned short	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif  /* _ASM_M32R_POSIX_TYPES_H */
-- 
1.8.2.1
