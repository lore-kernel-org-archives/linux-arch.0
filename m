From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH v4 01/16] rtc: cmos: remove empty
 asm/mc146818rtc.h files
Date: Mon, 30 May 2016 20:57:49 +0200
Message-ID: <1464634684-1248135-2-git-send-email-arnd@arndb.de>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDEKVJM7XAHRBPM2WK5AKGQE3ON4ABA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Nothing on these architectures ever includes the asm/mc146818rtc.h
file, the drivers that used to do this have been fixed long ago,
and the remaining users are all PC-specific.

This removes the files for good.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Acked-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/frv/include/asm/mc146818rtc.h    | 16 ----------------
 arch/h8300/include/asm/mc146818rtc.h  |  9 ---------
 arch/ia64/include/asm/mc146818rtc.h   | 10 ----------
 arch/parisc/include/asm/mc146818rtc.h |  9 ---------
 arch/sh/include/asm/mc146818rtc.h     |  7 -------
 5 files changed, 51 deletions(-)
 delete mode 100644 arch/frv/include/asm/mc146818rtc.h
 delete mode 100644 arch/h8300/include/asm/mc146818rtc.h
 delete mode 100644 arch/ia64/include/asm/mc146818rtc.h
 delete mode 100644 arch/parisc/include/asm/mc146818rtc.h
 delete mode 100644 arch/sh/include/asm/mc146818rtc.h

diff --git a/arch/frv/include/asm/mc146818rtc.h b/arch/frv/include/asm/mc146818rtc.h
deleted file mode 100644
index 90dfb7a633d1..000000000000
--- a/arch/frv/include/asm/mc146818rtc.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* mc146818rtc.h: RTC defs
- *
- * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _ASM_MC146818RTC_H
-#define _ASM_MC146818RTC_H
-
-
-#endif /* _ASM_MC146818RTC_H */
diff --git a/arch/h8300/include/asm/mc146818rtc.h b/arch/h8300/include/asm/mc146818rtc.h
deleted file mode 100644
index ab9d9646d241..000000000000
--- a/arch/h8300/include/asm/mc146818rtc.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * Machine dependent access functions for RTC registers.
- */
-#ifndef _H8300_MC146818RTC_H
-#define _H8300_MC146818RTC_H
-
-/* empty include file to satisfy the include in genrtc.c/ide-geometry.c */
-
-#endif /* _H8300_MC146818RTC_H */
diff --git a/arch/ia64/include/asm/mc146818rtc.h b/arch/ia64/include/asm/mc146818rtc.h
deleted file mode 100644
index 407787a237ba..000000000000
--- a/arch/ia64/include/asm/mc146818rtc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _ASM_IA64_MC146818RTC_H
-#define _ASM_IA64_MC146818RTC_H
-
-/*
- * Machine dependent access functions for RTC registers.
- */
-
-/* empty include file to satisfy the include in genrtc.c */
-
-#endif /* _ASM_IA64_MC146818RTC_H */
diff --git a/arch/parisc/include/asm/mc146818rtc.h b/arch/parisc/include/asm/mc146818rtc.h
deleted file mode 100644
index adf41631449f..000000000000
--- a/arch/parisc/include/asm/mc146818rtc.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * Machine dependent access functions for RTC registers.
- */
-#ifndef _ASM_MC146818RTC_H
-#define _ASM_MC146818RTC_H
-
-/* empty include file to satisfy the include in genrtc.c */
-
-#endif /* _ASM_MC146818RTC_H */
diff --git a/arch/sh/include/asm/mc146818rtc.h b/arch/sh/include/asm/mc146818rtc.h
deleted file mode 100644
index 0aee96a97330..000000000000
--- a/arch/sh/include/asm/mc146818rtc.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/*
- * Machine dependent access functions for RTC registers.
- */
-#ifndef _ASM_MC146818RTC_H
-#define _ASM_MC146818RTC_H
-
-#endif /* _ASM_MC146818RTC_H */
-- 
2.7.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
