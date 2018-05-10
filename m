From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 12/27] x86: um, annotate data appropriatelly
Date: Thu, 10 May 2018 10:06:29 +0200
Message-ID: <20180510080644.19752-13-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

Use the new SYM_DATA_START and SYM_DATA_END_LABEL macros for vdso_start.

We get:
  0000  2376 OBJECT  GLOBAL DEFAULT    4 vdso_start
  0948     0 OBJECT  GLOBAL DEFAULT    4 vdso_end

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
---
 arch/x86/um/vdso/vdso.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
index a4a3870dc059..a6eaf293a73b 100644
--- a/arch/x86/um/vdso/vdso.S
+++ b/arch/x86/um/vdso/vdso.S
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/init.h>
+#include <linux/linkage.h>
 
 __INITDATA
 
-	.globl vdso_start, vdso_end
-vdso_start:
+SYM_DATA_START(vdso_start)
 	.incbin "arch/x86/um/vdso/vdso.so"
-vdso_end:
+SYM_DATA_END_LABEL(vdso_start, SYM_L_GLOBAL, vdso_end)
 
 __FINIT
-- 
2.16.3
