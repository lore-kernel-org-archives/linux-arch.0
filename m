Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:10712 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S964959AbWIQLvv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 07:51:51 -0400
Date: Sun, 17 Sep 2006 20:51:37 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: All arch maintainers: 'make headers_check' fails on most architectures.
Message-ID: <20060917115137.GA19084@localhost.usen.ad.jp>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com> <1158478779.24527.209.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158478779.24527.209.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, spyro@f2s.com, starvik@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, davem@davemloft.net, wli@holomorphy.com, jdike@karaya.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net, rmk@arm.linux.org.uk, dhowells <dhowells@redhat.com>, ralf@linux-mips.org, kyle@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Sep 17, 2006 at 08:39:39AM +0100, David Woodhouse wrote:
> asm-sh/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
> asm-sh/ptrace.h requires asm/ubc.h, which does not exist in exported headers

Ok, these are fixed, patch attached.

> asm-sh64/page.h requires asm-generic/memory_model.h, which does not exist in exported headers

Fixed.

> asm-sh64/shmparam.h requires asm/cache.h, which does not exist in exported headers

This is going to need a little bit more work, but I've just bumped the
mask up for now. I just took care of the same issue on sh, so I'll carry
over the same fix for that later. SHMLBA at 0x4000 is "good enough" for
these caches for the time being, and fixes this issue.

> asm-sh64/signal.h requires asm/processor.h, which does not exist in exported headers
> asm-sh64/user.h requires asm/processor.h, which does not exist in exported headers

Dead headers, fixed.

Patches follow..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index 22dc9c2..f203131 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -26,6 +26,7 @@ #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/elf.h>
+#include <asm/ubc.h>
 
 static int hlt_counter=0;
 
diff --git a/include/asm-sh/page.h b/include/asm-sh/page.h
index 5a057b0..6f7eb8a 100644
--- a/include/asm-sh/page.h
+++ b/include/asm-sh/page.h
@@ -112,9 +112,8 @@ #define virt_addr_valid(kaddr)	pfn_valid
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
 #endif /* __ASM_SH_PAGE_H */
diff --git a/include/asm-sh/ptrace.h b/include/asm-sh/ptrace.h
index 792fc35..ed358a3 100644
--- a/include/asm-sh/ptrace.h
+++ b/include/asm-sh/ptrace.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_SH_PTRACE_H
 #define __ASM_SH_PTRACE_H
 
-#include <asm/ubc.h>
-
 /*
  * Copyright (C) 1999, 2000  Niibe Yutaka
  *

diff --git a/include/asm-sh64/page.h b/include/asm-sh64/page.h
index 34fb347..472089a 100644
--- a/include/asm-sh64/page.h
+++ b/include/asm-sh64/page.h
@@ -112,9 +112,8 @@ #define virt_addr_valid(kaddr)	pfn_valid
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
 #endif /* __ASM_SH64_PAGE_H */
diff --git a/include/asm-sh64/shmparam.h b/include/asm-sh64/shmparam.h
index d3a99a4..1bb820c 100644
--- a/include/asm-sh64/shmparam.h
+++ b/include/asm-sh64/shmparam.h
@@ -2,19 +2,11 @@ #ifndef __ASM_SH64_SHMPARAM_H
 #define __ASM_SH64_SHMPARAM_H
 
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * include/asm-sh64/shmparam.h
- *
- * Copyright (C) 2000, 2001  Paolo Alberelli
- *
+ * Set this to a sensible safe default, we'll work out the specifics for the
+ * align mask from the cache descriptor at run-time.
  */
+#define	SHMLBA	0x4000
 
-#include <asm/cache.h>
-
-/* attach addr a multiple of this */
-#define	SHMLBA	(cpu_data->dcache.sets * L1_CACHE_BYTES)
+#define __ARCH_FORCE_SHMLBA
 
 #endif /* __ASM_SH64_SHMPARAM_H */
diff --git a/include/asm-sh64/signal.h b/include/asm-sh64/signal.h
index a5a2820..244e134 100644
--- a/include/asm-sh64/signal.h
+++ b/include/asm-sh64/signal.h
@@ -13,7 +13,6 @@ #define __ASM_SH64_SIGNAL_H
  */
 
 #include <linux/types.h>
-#include <asm/processor.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff --git a/include/asm-sh64/user.h b/include/asm-sh64/user.h
index 8f32f39..eb3b33e 100644
--- a/include/asm-sh64/user.h
+++ b/include/asm-sh64/user.h
@@ -13,7 +13,6 @@ #define __ASM_SH64_USER_H
  */
 
 #include <linux/types.h>
-#include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
 
