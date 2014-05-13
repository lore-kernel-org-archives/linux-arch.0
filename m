From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 15/25] mn10300: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:05:51 +0800
Message-ID: <1399971951-4524-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com
List-Id: linux-arch.vger.kernel.org

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/mn10300/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mn10300/include/uapi/asm/posix_types.h b/arch/mn10300/include/uapi/asm/posix_types.h
index d31eeea..669ed1b 100644
--- a/arch/mn10300/include/uapi/asm/posix_types.h
+++ b/arch/mn10300/include/uapi/asm/posix_types.h
@@ -40,6 +40,12 @@ typedef int		__kernel_ptrdiff_t;
 typedef unsigned short	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _ASM_POSIX_TYPES_H */
-- 
1.8.2.1
