Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbfARQUl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2019 11:20:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 01/29] ia64: add __NR_umount2 definition
Date: Fri, 18 Jan 2019 17:18:07 +0100
Message-ID: <20190118161835.2259170-2-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com, akpm@linux-foundation.org, deepa.kernel@gmail.com, ebiederm@xmission.com, firoz.khan@linaro.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20190118161807.SsnvA3fH9zenxLnL7F2OBoGUcZuAythQlMX_lXsr_TE@z>

Other architectures commonly use __NR_umount2 for sys_umount,
only ia64 and alpha use __NR_umount here. In order to synchronize
the generated tables, use umount2 like everyone else, and add back
the old name from asm/unistd.h for compatibility.

The __IGNORE_* lines are now all obsolete and can be removed as
a side-effect.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/asm/unistd.h        | 14 --------------
 arch/ia64/include/uapi/asm/unistd.h   |  2 ++
 arch/ia64/kernel/syscalls/syscall.tbl |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index 0b08ebd2dfde..9ba6110b10b9 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -12,20 +12,6 @@
 
 #define NR_syscalls		__NR_syscalls /* length of syscall table */
 
-/*
- * The following defines stop scripts/checksyscalls.sh from complaining about
- * unimplemented system calls.  Glibc provides for each of these by using
- * more modern equivalent system calls.
- */
-#define __IGNORE_fork		/* clone() */
-#define __IGNORE_time		/* gettimeofday() */
-#define __IGNORE_alarm		/* setitimer(ITIMER_REAL, ... */
-#define __IGNORE_pause		/* rt_sigprocmask(), rt_sigsuspend() */
-#define __IGNORE_utime		/* utimes() */
-#define __IGNORE_getpgrp	/* getpgid() */
-#define __IGNORE_vfork		/* clone() */
-#define __IGNORE_umount2	/* umount() */
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_UTIME
 
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index b2513922dcb5..013e0bcacc39 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -15,6 +15,8 @@
 
 #define __NR_Linux      1024
 
+#define __NR_umount __NR_umount2
+
 #include <asm/unistd_64.h>
 
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b22203b40bfe..e97caf51be42 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 17	common	getpid				sys_getpid
 18	common	getppid				sys_getppid
 19	common	mount				sys_mount
-20	common	umount				sys_umount
+20	common	umount2				sys_umount
 21	common	setuid				sys_setuid
 22	common	getuid				sys_getuid
 23	common	geteuid				sys_geteuid
-- 
2.20.0
