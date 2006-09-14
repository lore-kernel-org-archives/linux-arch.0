Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:54722 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932068AbWINWgc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Sep 2006 18:36:32 -0400
Subject: [PATCH] [3/5] Fix 'make headers_check' on ia64 for 2.6.18
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 23:36:10 +0100
Message-Id: <1158273370.4312.142.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-12 at 17:44 +0100, David Woodhouse wrote:
> asm-ia64/ptrace.h requires asm/asm-offsets.h, which does not exist
> asm-ia64/resource.h requires asm/ustack.h, which does not exist 

Hide parts which shouldn't be visible to userspace.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

index 85d6f80..f1cb00f 100644
--- a/include/asm-ia64/Kbuild
+++ b/include/asm-ia64/Kbuild
@@ -4,4 +4,4 @@ header-y += break.h fpu.h fpswa.h gcc_in
 	 intel_intrin.h intrinsics.h perfmon_default_smpl.h	\
 	 ptrace_offsets.h rse.h setup.h ucontext.h
 
-unifdef-y += perfmon.h
+unifdef-y += perfmon.h ustack.h
diff --git a/include/asm-ia64/page.h b/include/asm-ia64/page.h
index f5a949e..947cb72 100644
--- a/include/asm-ia64/page.h
+++ b/include/asm-ia64/page.h
@@ -7,6 +7,7 @@ #define _ASM_IA64_PAGE_H
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
+# ifdef __KERNEL__
 
 #include <asm/intrinsics.h>
 #include <asm/types.h>
@@ -64,7 +65,6 @@ #ifdef __ASSEMBLY__
 # define __pa(x)		((x) - PAGE_OFFSET)
 # define __va(x)		((x) + PAGE_OFFSET)
 #else /* !__ASSEMBLY */
-# ifdef __KERNEL__
 #  define STRICT_MM_TYPECHECKS
 
 extern void clear_page (void *page);
@@ -174,7 +174,6 @@ get_order (unsigned long size)
 	return order;
 }
 
-# endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
 
 #ifdef STRICT_MM_TYPECHECKS
@@ -228,4 +227,5 @@ #define VM_DATA_DEFAULT_FLAGS		(VM_READ 
 					 (((current->personality & READ_IMPLIES_EXEC) != 0)	\
 					  ? VM_EXEC : 0))
 
+# endif /* __KERNEL__ */
 #endif /* _ASM_IA64_PAGE_H */
diff --git a/include/asm-ia64/ptrace.h b/include/asm-ia64/ptrace.h
index 415abb2..1414316 100644
--- a/include/asm-ia64/ptrace.h
+++ b/include/asm-ia64/ptrace.h
@@ -56,6 +56,8 @@ #define _ASM_IA64_PTRACE_H
 
 
 #include <asm/fpu.h>
+
+#ifdef __KERNEL__
 #ifndef ASM_OFFSETS_C
 #include <asm/asm-offsets.h>
 #endif
@@ -79,10 +81,9 @@ #define IA64_STK_OFFSET			((1 << KERNEL_
 
 #define KERNEL_STACK_SIZE		IA64_STK_OFFSET
 
-#ifndef __ASSEMBLY__
+#endif /* __KERNEL__ */
 
-#include <asm/current.h>
-#include <asm/page.h>
+#ifndef __ASSEMBLY__
 
 /*
  * This struct defines the way the registers are saved on system
@@ -229,6 +230,9 @@ struct switch_stack {
 
 #ifdef __KERNEL__
 
+#include <asm/current.h>
+#include <asm/page.h>
+
 #define __ARCH_SYS_PTRACE	1
 
 /*
diff --git a/include/asm-ia64/ustack.h b/include/asm-ia64/ustack.h
index da55c91..a349467 100644
--- a/include/asm-ia64/ustack.h
+++ b/include/asm-ia64/ustack.h
@@ -5,12 +5,15 @@ #define _ASM_IA64_USTACK_H
  * Constants for the user stack size
  */
 
+#ifdef __KERNEL__
 #include <asm/page.h>
 
 /* The absolute hard limit for stack size is 1/2 of the mappable space in the region */
 #define MAX_USER_STACK_SIZE	(RGN_MAP_LIMIT/2)
-/* Make a default stack size of 2GB */
-#define DEFAULT_USER_STACK_SIZE	(1UL << 31)
 #define STACK_TOP		(0x6000000000000000UL + RGN_MAP_LIMIT)
+#endif
+
+/* Make a default stack size of 2GiB */
+#define DEFAULT_USER_STACK_SIZE	(1UL << 31)
 
 #endif /* _ASM_IA64_USTACK_H */

-- 
dwmw2

