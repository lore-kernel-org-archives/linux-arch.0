Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58779 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751411Ab2EZIsX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 May 2012 04:48:23 -0400
Message-ID: <1338022099.3087.2.camel@dabdike.int.hansenpartnership.com>
Subject: [PATCH v2] update parisc to use generic strncpy_from_user()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 26 May 2012 09:48:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Parisc List <linux-parisc@vger.kernel.org>, linux-arch@vger.kernel.org
Cc: David Miller <davem@davemloft.net>
Message-ID: <20120526084819.YJRkGvqZII-1U36qrsKSaJOp7vM2qWv9xOkzcfiwuXM@z>

I'll queue this patch in our git repo.  It seems to work fine for us,
thanks, Dave!

v2: use test_thread_flag() for max addr determination instead of
tsk->thread.task_size

James

---

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index ddb8b24..3ff21b5 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -18,6 +18,7 @@ config PARISC
 	select IRQ_PER_CPU
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 0e8b7b8..1419924 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -40,12 +40,16 @@
 #define DEFAULT_TASK_SIZE32	(0xFFF00000UL)
 #define DEFAULT_MAP_BASE32	(0x40000000UL)
 
+/* FIXME: remove task_size from current->thread and remove TMP_TASK_SIZE */
 #ifdef CONFIG_64BIT
 #define DEFAULT_TASK_SIZE       (MAX_ADDRESS-0xf000000)
 #define DEFAULT_MAP_BASE        (0x200000000UL)
+#define TMP_TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
+					DEFAULT_TASK_SIZE32 : DEFAULT_TASK_SIZE)
 #else
 #define DEFAULT_TASK_SIZE	DEFAULT_TASK_SIZE32
 #define DEFAULT_MAP_BASE	DEFAULT_MAP_BASE32
+#define TMP_TASK_SIZE		DEFAULT_TASK_SIZE32
 #endif
 
 #ifdef __KERNEL__
diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index 9ac0660..95e656b 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -5,6 +5,7 @@
  * User space memory access functions
  */
 #include <asm/page.h>
+#include <asm/pgtable.h>	/* for MAX_ADDRESS */
 #include <asm/cache.h>
 #include <asm/errno.h>
 #include <asm-generic/uaccess-unaligned.h>
@@ -218,15 +219,15 @@ struct exception_data {
 extern unsigned long lcopy_to_user(void __user *, const void *, unsigned long);
 extern unsigned long lcopy_from_user(void *, const void __user *, unsigned long);
 extern unsigned long lcopy_in_user(void __user *, const void __user *, unsigned long);
-extern long lstrncpy_from_user(char *, const char __user *, long);
+extern long strncpy_from_user(char *, const char __user *, long);
 extern unsigned lclear_user(void __user *,unsigned long);
 extern long lstrnlen_user(const char __user *,long);
-
 /*
  * Complex access routines -- macros
  */
+#define user_addr_max() \
+	(segment_eq(get_fs(), USER_DS) ? TMP_TASK_SIZE : ~0UL)
 
-#define strncpy_from_user lstrncpy_from_user
 #define strnlen_user lstrnlen_user
 #define strlen_user(str) lstrnlen_user(str, 0x7fffffffL)
 #define clear_user lclear_user
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index a7bb757..ceec85d 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -44,7 +44,6 @@ EXPORT_SYMBOL(__cmpxchg_u64);
 #endif
 
 #include <asm/uaccess.h>
-EXPORT_SYMBOL(lstrncpy_from_user);
 EXPORT_SYMBOL(lclear_user);
 EXPORT_SYMBOL(lstrnlen_user);
 
diff --git a/arch/parisc/lib/lusercopy.S b/arch/parisc/lib/lusercopy.S
index 1bd23cc..6f2d935 100644
--- a/arch/parisc/lib/lusercopy.S
+++ b/arch/parisc/lib/lusercopy.S
@@ -61,47 +61,6 @@
 	.endm
 
 	/*
-	 * long lstrncpy_from_user(char *dst, const char *src, long n)
-	 *
-	 * Returns -EFAULT if exception before terminator,
-	 *         N if the entire buffer filled,
-	 *         otherwise strlen (i.e. excludes zero byte)
-	 */
-
-ENTRY(lstrncpy_from_user)
-	.proc
-	.callinfo NO_CALLS
-	.entry
-	comib,=     0,%r24,$lsfu_done
-	copy        %r24,%r23
-	get_sr
-1:      ldbs,ma     1(%sr1,%r25),%r1
-$lsfu_loop:
-	stbs,ma     %r1,1(%r26)
-	comib,=,n   0,%r1,$lsfu_done
-	addib,<>,n  -1,%r24,$lsfu_loop
-2:      ldbs,ma     1(%sr1,%r25),%r1
-$lsfu_done:
-	sub         %r23,%r24,%r28
-$lsfu_exit:
-	bv          %r0(%r2)
-	nop
-	.exit
-ENDPROC(lstrncpy_from_user)
-
-	.section .fixup,"ax"
-3:      fixup_branch $lsfu_exit
-	ldi         -EFAULT,%r28
-	.previous
-
-	.section __ex_table,"aw"
-	ASM_ULONG_INSN 1b,3b
-	ASM_ULONG_INSN 2b,3b
-	.previous
-
-	.procend
-
-	/*
 	 * unsigned long lclear_user(void *to, unsigned long n)
 	 *
 	 * Returns 0 for success.


