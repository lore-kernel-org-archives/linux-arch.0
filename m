Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262825AbUKXTCn@vger.kernel.org>
Received: from fmr24.intel.com ([143.183.121.16]:45956 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262823AbUKXTBq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Nov 2004 14:01:46 -0500
Date: Wed, 24 Nov 2004 11:00:32 -0800
From: tony.luck@intel.com
Message-Id: <200411241900.iAOJ0Wd31749@unix-os.sc.intel.com>
Subject: Re: [patch] sys_stime needs a compat function.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> The original stime bug is fixed for mips, parisc, s390, sparc64 and
> x86_64. Can the arch-maintainers please take a look at this?

You missed providing a definition for __ARCH_WANT_COMPAT_SYS_TIME for
ia64.

===== include/asm-ia64/unistd.h 1.53 vs edited =====
--- 1.53/include/asm-ia64/unistd.h	2004-11-23 12:18:59 -08:00
+++ edited/include/asm-ia64/unistd.h	2004-11-24 10:51:05 -08:00
@@ -281,6 +281,7 @@
 # define __ARCH_WANT_SYS_OLDUMOUNT
 # define __ARCH_WANT_SYS_SIGPENDING
 # define __ARCH_WANT_SYS_SIGPROCMASK
+# define __ARCH_WANT_COMPAT_SYS_TIME
 #endif
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)

Also I ended up with security_settime() undefined.  I think you
need to add "#include <linux/security.h> to kernel/compat.c

-Tony
