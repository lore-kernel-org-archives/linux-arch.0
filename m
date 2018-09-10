From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 3/8] remove termios-base.h
Date: Mon, 10 Sep 2018 05:52:22 +0100
Message-ID: <20180910045227.9895-3-viro@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

empty now

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/include/asm/termios.h |  2 --
 arch/s390/include/asm/termios.h    |  2 --
 include/asm-generic/termios-base.h | 10 ----------
 3 files changed, 14 deletions(-)
 delete mode 100644 include/asm-generic/termios-base.h

diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios.h
index b8353e2032d0..cb1e593e95bf 100644
--- a/arch/powerpc/include/asm/termios.h
+++ b/arch/powerpc/include/asm/termios.h
@@ -17,6 +17,4 @@
 /*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
 #define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
 
-#include <asm-generic/termios-base.h>
-
 #endif	/* _ASM_POWERPC_TERMIOS_H */
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
index 62759ac7a92b..7ee16b5dcb6f 100644
--- a/arch/s390/include/asm/termios.h
+++ b/arch/s390/include/asm/termios.h
@@ -18,6 +18,4 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-#include <asm-generic/termios-base.h>
-
 #endif	/* _S390_TERMIOS_H */
diff --git a/include/asm-generic/termios-base.h b/include/asm-generic/termios-base.h
deleted file mode 100644
index 63d948ab6746..000000000000
--- a/include/asm-generic/termios-base.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* termios.h: generic termios/termio user copying/translation
- */
-
-#ifndef _ASM_GENERIC_TERMIOS_BASE_H
-#define _ASM_GENERIC_TERMIOS_BASE_H
-
-#include <linux/uaccess.h>
-
-#endif /* _ASM_GENERIC_TERMIOS_BASE_H */
-- 
2.11.0
