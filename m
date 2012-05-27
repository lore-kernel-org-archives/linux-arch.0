From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] openrisc: use generic strnlen_user() function
Date: Sun, 27 May 2012 10:25:47 +0200
Message-ID: <1338107147-27760-1-git-send-email-jonas@southpole.se>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:48400 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab2E0IZK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2012 04:25:10 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, linux-arch@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>


The generic version is both easier to support and more correct.

Signed-off-by: Jonas Bonn <jonas@southpole.se>
---
 arch/openrisc/Kconfig               |    1 +
 arch/openrisc/include/asm/uaccess.h |   30 +--------------------
 arch/openrisc/lib/string.S          |   47 -----------------------------------
 3 files changed, 3 insertions(+), 75 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index ee4d124..3f40c98 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -20,6 +20,7 @@ config OPENRISC
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 
 config MMU
 	def_bool y
diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 04b93de..ab2e7a1 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -318,33 +318,7 @@ clear_user(void *addr, unsigned long size)
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
-/*
- * Return the size of a string (including the ending 0)
- *
- * Return 0 for error
- */
-
-extern int __strnlen_user(const char *str, long len, unsigned long top);
-
-/*
- * Returns the length of the string at str (including the null byte),
- * or 0 if we hit a page we can't access,
- * or something > len if we didn't find a null byte.
- *
- * The `top' parameter to __strnlen_user is to make sure that
- * we can never overflow from the user area into kernel space.
- */
-static inline long strnlen_user(const char __user *str, long len)
-{
-	unsigned long top = (unsigned long)get_fs();
-	unsigned long res = 0;
-
-	if (__addr_ok(str))
-		res = __strnlen_user(str, len, top);
-
-	return res;
-}
-
-#define strlen_user(str) strnlen_user(str, TASK_SIZE-1)
+extern __must_check long strlen_user(const char __user *str);
+extern __must_check long strnlen_user(const char __user *str, long n);
 
 #endif /* __ASM_OPENRISC_UACCESS_H */
diff --git a/arch/openrisc/lib/string.S b/arch/openrisc/lib/string.S
index 8ceb11e..c09fee7 100644
--- a/arch/openrisc/lib/string.S
+++ b/arch/openrisc/lib/string.S
@@ -103,50 +103,3 @@ __clear_user:
 	.section __ex_table, "a"
 		.long 9b, 99b		// write fault
 	.previous
-
-
-/*
- * extern int __strnlen_user(const char *str, long len, unsigned long top);
- *
- *
- * RTRN: - length of a string including NUL termination character
- *       - on page fault 0
- */
-
-	.global __strnlen_user
-__strnlen_user:
-	l.addi  r1,r1,-8
-	l.sw    0(r1),r6
-	l.sw    4(r1),r3
-
-	l.addi  r11,r0,0
-2:  	l.sfeq  r11,r4
-	l.bf    1f
-	l.addi  r11,r11,1
-8:    	l.lbz   r6,0(r3)
-	l.sfeq  r6,r0
-	l.bf    1f
-	l.sfgeu r3,r5                  // are we over the top ?
-	l.bf    99f
-	l.j     2b
-	l.addi  r3,r3,1
-
-1:
-	l.lwz   r6,0(r1)
-	l.lwz	r3,4(r1)
-	l.jr    r9
-	l.addi  r1,r1,8
-
-	.section .fixup, "ax"
-99:
-		l.addi  r11,r0,0
-
-		l.lwz   r6,0(r1)
-		l.lwz	r3,4(r1)
-		l.jr	r9
-		l.addi  r1,r1,8
-	.previous
-
-	.section __ex_table, "a"
-		.long 8b, 99b		// read fault
-	.previous
-- 
1.7.0.4
