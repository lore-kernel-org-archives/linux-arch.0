From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 05/25] blackfin: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:02:55 +0800
Message-ID: <1399971775-4153-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/blackfin/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/blackfin/include/uapi/asm/posix_types.h b/arch/blackfin/include/uapi/asm/posix_types.h
index 9608ef6..e005638 100644
--- a/arch/blackfin/include/uapi/asm/posix_types.h
+++ b/arch/blackfin/include/uapi/asm/posix_types.h
@@ -25,6 +25,12 @@ typedef unsigned short __kernel_old_gid_t;
 typedef unsigned short __kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long __kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long __kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _UAPI__ARCH_BFIN_POSIX_TYPES_H */
-- 
1.8.2.1
