From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 13/25] microblaze: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:05:19 +0800
Message-ID: <1399971919-4450-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Michal Simek <monstr@monstr.eu>
List-Id: linux-arch.vger.kernel.org

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/microblaze/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/microblaze/include/uapi/asm/posix_types.h b/arch/microblaze/include/uapi/asm/posix_types.h
index 0e15039..20e5d98 100644
--- a/arch/microblaze/include/uapi/asm/posix_types.h
+++ b/arch/microblaze/include/uapi/asm/posix_types.h
@@ -4,6 +4,12 @@
 typedef unsigned short	__kernel_mode_t;
 #define __kernel_mode_t __kernel_mode_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _ASM_MICROBLAZE_POSIX_TYPES_H */
-- 
1.8.2.1
