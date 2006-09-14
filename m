Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:49346 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932065AbWINWfp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Sep 2006 18:35:45 -0400
Subject: [PATCH] [2/5] Fix 'make headers_check' on s390 for 2.6.18
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 23:35:42 +0100
Message-Id: <1158273343.4312.141.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-12 at 17:44 +0100, David Woodhouse wrote:
> asm-s390/debug.h requires linux/string.h, which does not exist
> asm-s390/elf.h requires asm/system.h, which does not exist 

Move things around slightly so the right things end up within 
#ifdef __KERNEL__ and thus don't pollute the exported headers.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-s390/debug.h b/include/asm-s390/debug.h
index 7f1ef99..c00dd2b 100644
--- a/include/asm-s390/debug.h
+++ b/include/asm-s390/debug.h
@@ -10,7 +10,6 @@ #ifndef DEBUG_H
 #define DEBUG_H
 
 #include <linux/fs.h>
-#include <linux/string.h>
 
 /* Note:
  * struct __debug_entry must be defined outside of #ifdef __KERNEL__ 
@@ -35,6 +34,7 @@ struct __debug_entry{
 #define __DEBUG_FEATURE_VERSION      2  /* version of debug feature */
 
 #ifdef __KERNEL__
+#include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
diff --git a/include/asm-s390/elf.h b/include/asm-s390/elf.h
index 710646e..c0d629d 100644
--- a/include/asm-s390/elf.h
+++ b/include/asm-s390/elf.h
@@ -93,19 +93,6 @@ #define R_390_TLS_GOTIE20	60	/* 20 bit G
 #define R_390_NUM	61
 
 /*
- * ELF register definitions..
- */
-
-#include <linux/sched.h>	/* for task_struct */
-#include <asm/ptrace.h>
-#include <asm/user.h>
-#include <asm/system.h>		/* for save_access_regs */
-
-
-typedef s390_fp_regs elf_fpregset_t;
-typedef s390_regs elf_gregset_t;
-
-/*
  * These are used to set parameters in the core dumps.
  */
 #ifndef __s390x__
@@ -117,6 +104,20 @@ #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
 /*
+ * ELF register definitions..
+ */
+
+#include <asm/ptrace.h>
+#include <asm/user.h>
+
+typedef s390_fp_regs elf_fpregset_t;
+typedef s390_regs elf_gregset_t;
+
+#ifdef __KERNEL__
+#include <linux/sched.h>	/* for task_struct */
+#include <asm/system.h>		/* for save_access_regs */
+
+/*
  * This is used to ensure we don't load something for the wrong architecture.
  */
 #define elf_check_arch(x) \
@@ -198,7 +199,6 @@ #define ELF_HWCAP (0)
 
 #define ELF_PLATFORM (NULL)
 
-#ifdef __KERNEL__
 #ifndef __s390x__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
 #else /* __s390x__ */

-- 
dwmw2

