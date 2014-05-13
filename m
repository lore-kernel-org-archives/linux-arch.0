From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 25/25] xtense: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:06:50 +0800
Message-ID: <1399972010-4890-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
List-Id: linux-arch.vger.kernel.org

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/xtensa/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/xtensa/include/uapi/asm/posix_types.h b/arch/xtensa/include/uapi/asm/posix_types.h
index 6e96be0..0001106 100644
--- a/arch/xtensa/include/uapi/asm/posix_types.h
+++ b/arch/xtensa/include/uapi/asm/posix_types.h
@@ -34,6 +34,12 @@ typedef unsigned short	__kernel_old_gid_t;
 typedef unsigned short	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _XTENSA_POSIX_TYPES_H */
-- 
1.8.2.1
