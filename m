From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/3] Reduce get_current() to the asm-generic implementation
	where possible
Date: Tue, 18 May 2010 17:45:37 +0100
Message-ID: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34337 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756708Ab0ERRen (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 May 2010 13:34:43 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o4IHYfEj030742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Tue, 18 May 2010 13:34:42 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: oleg@redhat.com, linux-arch@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>

Reduce get_current() to the asm-generic implementation where possible to remove
duplicate cases.

Note that this will lose the const attribute on get_current() for ARM and
MN10300.  This will be added back in a later patch for all architectures.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/alpha/include/asm/current.h   |   10 +---------
 arch/arm/include/asm/current.h     |   16 +---------------
 arch/avr32/include/asm/current.h   |   16 +---------------
 arch/cris/include/asm/current.h    |   16 +---------------
 arch/h8300/include/asm/current.h   |   26 +-------------------------
 arch/m32r/include/asm/current.h    |   16 +---------------
 arch/m68k/include/asm/current.h    |   13 ++-----------
 arch/mn10300/include/asm/current.h |    8 +-------
 arch/parisc/include/asm/current.h  |   16 +---------------
 arch/sparc/include/asm/current.h   |    7 +------
 arch/xtensa/include/asm/current.h  |   13 +------------
 11 files changed, 12 insertions(+), 145 deletions(-)

diff --git a/arch/alpha/include/asm/current.h b/arch/alpha/include/asm/current.h
index 094d285..4c51401 100644
--- a/arch/alpha/include/asm/current.h
+++ b/arch/alpha/include/asm/current.h
@@ -1,9 +1 @@
-#ifndef _ALPHA_CURRENT_H
-#define _ALPHA_CURRENT_H
-
-#include <linux/thread_info.h>
-
-#define get_current()	(current_thread_info()->task)
-#define current		get_current()
-
-#endif /* _ALPHA_CURRENT_H */
+#include <asm-generic/current.h>
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
index 75d21e2..4c51401 100644
--- a/arch/arm/include/asm/current.h
+++ b/arch/arm/include/asm/current.h
@@ -1,15 +1 @@
-#ifndef _ASMARM_CURRENT_H
-#define _ASMARM_CURRENT_H
-
-#include <linux/thread_info.h>
-
-static inline struct task_struct *get_current(void) __attribute_const__;
-
-static inline struct task_struct *get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current (get_current())
-
-#endif /* _ASMARM_CURRENT_H */
+#include <asm-generic/current.h>
diff --git a/arch/avr32/include/asm/current.h b/arch/avr32/include/asm/current.h
index c7b0549..4c51401 100644
--- a/arch/avr32/include/asm/current.h
+++ b/arch/avr32/include/asm/current.h
@@ -1,15 +1 @@
-#ifndef __ASM_AVR32_CURRENT_H
-#define __ASM_AVR32_CURRENT_H
-
-#include <linux/thread_info.h>
-
-struct task_struct;
-
-inline static struct task_struct * get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current get_current()
-
-#endif /* __ASM_AVR32_CURRENT_H */
+#include <asm-generic/current.h>
diff --git a/arch/cris/include/asm/current.h b/arch/cris/include/asm/current.h
index 5f5c0ef..4c51401 100644
--- a/arch/cris/include/asm/current.h
+++ b/arch/cris/include/asm/current.h
@@ -1,15 +1 @@
-#ifndef _CRIS_CURRENT_H
-#define _CRIS_CURRENT_H
-
-#include <linux/thread_info.h>
-
-struct task_struct;
-
-static inline struct task_struct * get_current(void)
-{
-        return current_thread_info()->task;
-}
- 
-#define current get_current()
-
-#endif /* !(_CRIS_CURRENT_H) */
+#include <asm-generic/current.h>
diff --git a/arch/h8300/include/asm/current.h b/arch/h8300/include/asm/current.h
index 57d74ee..4c51401 100644
--- a/arch/h8300/include/asm/current.h
+++ b/arch/h8300/include/asm/current.h
@@ -1,25 +1 @@
-#ifndef _H8300_CURRENT_H
-#define _H8300_CURRENT_H
-/*
- *	current.h
- *	(C) Copyright 2000, Lineo, David McCullough <davidm@lineo.com>
- *	(C) Copyright 2002, Greg Ungerer (gerg@snapgear.com)
- *
- *	rather than dedicate a register (as the m68k source does), we
- *	just keep a global,  we should probably just change it all to be
- *	current and lose _current_task.
- */
-
-#include <linux/thread_info.h>
-#include <asm/thread_info.h>
-
-struct task_struct;
-
-static inline struct task_struct *get_current(void)
-{
-	return(current_thread_info()->task);
-}
-
-#define	current	get_current()
-
-#endif /* _H8300_CURRENT_H */
+#include <asm-generic/current.h>
diff --git a/arch/m32r/include/asm/current.h b/arch/m32r/include/asm/current.h
index 7859d86..4c51401 100644
--- a/arch/m32r/include/asm/current.h
+++ b/arch/m32r/include/asm/current.h
@@ -1,15 +1 @@
-#ifndef _ASM_M32R_CURRENT_H
-#define _ASM_M32R_CURRENT_H
-
-#include <linux/thread_info.h>
-
-struct task_struct;
-
-static __inline__ struct task_struct *get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current	(get_current())
-
-#endif	/* _ASM_M32R_CURRENT_H */
+#include <asm-generic/current.h>
diff --git a/arch/m68k/include/asm/current.h b/arch/m68k/include/asm/current.h
index 91fcc53..e279667 100644
--- a/arch/m68k/include/asm/current.h
+++ b/arch/m68k/include/asm/current.h
@@ -12,17 +12,8 @@ register struct task_struct *current __asm__("%a2");
  *	just keep a global,  we should probably just change it all to be
  *	current and lose _current_task.
  */
-#include <linux/thread_info.h>
+#include <asm-generic/current.h>
 
-struct task_struct;
-
-static inline struct task_struct *get_current(void)
-{
-	return(current_thread_info()->task);
-}
-
-#define	current	get_current()
-
-#endif /* CONFNIG_MMU */
+#endif /* CONFIG_MMU */
 
 #endif /* !(_M68K_CURRENT_H) */
diff --git a/arch/mn10300/include/asm/current.h b/arch/mn10300/include/asm/current.h
index ca6027d..c1ee370 100644
--- a/arch/mn10300/include/asm/current.h
+++ b/arch/mn10300/include/asm/current.h
@@ -25,13 +25,7 @@ register struct task_struct *const current asm("e2") __attribute__((used));
 extern struct task_struct *__current;
 
 #else
-static inline __attribute__((const))
-struct task_struct *get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current get_current()
+#include <asm-generic/current.h>
 #endif
 
 #endif /* _ASM_CURRENT_H */
diff --git a/arch/parisc/include/asm/current.h b/arch/parisc/include/asm/current.h
index 0fb9338..4c51401 100644
--- a/arch/parisc/include/asm/current.h
+++ b/arch/parisc/include/asm/current.h
@@ -1,15 +1 @@
-#ifndef _PARISC_CURRENT_H
-#define _PARISC_CURRENT_H
-
-#include <linux/thread_info.h>
-
-struct task_struct;
-
-static inline struct task_struct * get_current(void)
-{
-	return current_thread_info()->task;
-}
- 
-#define current get_current()
-
-#endif /* !(_PARISC_CURRENT_H) */
+#include <asm-generic/current.h>
diff --git a/arch/sparc/include/asm/current.h b/arch/sparc/include/asm/current.h
index 10a0df5..f04fd6c 100644
--- a/arch/sparc/include/asm/current.h
+++ b/arch/sparc/include/asm/current.h
@@ -23,12 +23,7 @@ register struct task_struct *current asm("g4");
  * Two stage process (inline + #define) for type-checking.
  * We also obfuscate get_current() to check if anyone used that by mistake.
  */
-struct task_struct;
-static inline struct task_struct *__get_current(void)
-{
-	return current_thread_info()->task;
-}
-#define current __get_current()
+#include <asm-generic/current.h>
 #endif
 
 #endif /* !(_SPARC_CURRENT_H) */
diff --git a/arch/xtensa/include/asm/current.h b/arch/xtensa/include/asm/current.h
index 8d1eb5d..c3398ce 100644
--- a/arch/xtensa/include/asm/current.h
+++ b/arch/xtensa/include/asm/current.h
@@ -12,18 +12,7 @@
 #define _XTENSA_CURRENT_H
 
 #ifndef __ASSEMBLY__
-
-#include <linux/thread_info.h>
-
-struct task_struct;
-
-static inline struct task_struct *get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current get_current()
-
+#include <asm-generic/current.h>
 #else
 
 #define CURRENT_SHIFT 13
