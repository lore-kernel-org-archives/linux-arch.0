From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 20/25] score: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:06:23 +0800
Message-ID: <1399971983-4707-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/score/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/score/include/uapi/asm/posix_types.h b/arch/score/include/uapi/asm/posix_types.h
index b88acf8..4c3843a 100644
--- a/arch/score/include/uapi/asm/posix_types.h
+++ b/arch/score/include/uapi/asm/posix_types.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_SCORE_POSIX_TYPES_H
 #define _ASM_SCORE_POSIX_TYPES_H
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _ASM_SCORE_POSIX_TYPES_H */
-- 
1.8.2.1
