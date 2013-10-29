From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v2] arch: use ASM_NL instead of ';' for assembler new line
 character in the macro
Date: Tue, 29 Oct 2013 09:51:22 +0800
Message-ID: <526F149A.3000306@asianux.com>
References: <526E3CE2.2070405@asianux.com> <526E6A92.6090301@synopsys.com> <526F09B8.9030202@asianux.com> <526F11C0.1030809@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:20501 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896Ab3J2BwZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2013 21:52:25 -0400
In-Reply-To: <526F11C0.1030809@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Vineet Gupta <vineetg76@gmail.com>, James Hogan <james.hogan@imgtec.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Max Filippov <jcmvbkbc@gmail.com>

For some assemblers, they use another character as newline in a macro
(e.g. arc uses '`'), so for generic assembly code, need use ASM_NL (a
macro) instead of ';' for it.

Also need notice about code styles ('\t' for each line).


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arc/include/asm/linkage.h |    2 ++
 include/linux/linkage.h        |   19 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index 0283e9e..66ee552 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -11,6 +11,8 @@
 
 #ifdef __ASSEMBLY__
 
+#define ASM_NL		 `	/* use '`' to mark new line in macro */
+
 /* Can't use the ENTRY macro in linux/linkage.h
  * gas considers ';' as comment vs. newline
  */
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index d3e8ad2..a6a42dd 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -6,6 +6,11 @@
 #include <linux/export.h>
 #include <asm/linkage.h>
 
+/* Some toolchains use other characters (e.g. '`') to mark new line in macro */
+#ifndef ASM_NL
+#define ASM_NL		 ;
+#endif
+
 #ifdef __cplusplus
 #define CPP_ASMLINKAGE extern "C"
 #else
@@ -75,21 +80,21 @@
 
 #ifndef ENTRY
 #define ENTRY(name) \
-  .globl name; \
-  ALIGN; \
-  name:
+	.globl name ASM_NL \
+	ALIGN ASM_NL \
+	name:
 #endif
 #endif /* LINKER_SCRIPT */
 
 #ifndef WEAK
 #define WEAK(name)	   \
-	.weak name;	   \
+	.weak name ASM_NL   \
 	name:
 #endif
 
 #ifndef END
 #define END(name) \
-  .size name, .-name
+	.size name, .-name
 #endif
 
 /* If symbol 'name' is treated as a subroutine (gets called, and returns)
@@ -98,8 +103,8 @@
  */
 #ifndef ENDPROC
 #define ENDPROC(name) \
-  .type name, @function; \
-  END(name)
+	.type name, @function ASM_NL \
+	END(name)
 #endif
 
 #endif
-- 
1.7.7.6
