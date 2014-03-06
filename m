From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 01/16] compat: let architectures define __ARCH_WANT_COMPAT_SYS_GETDENTS64
Date: Thu,  6 Mar 2014 16:51:08 +0100
Message-ID: <1394121083-2507-2-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:44179 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbaCFPvb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:31 -0500
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 81C04219004D
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:23 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpFtn55050436
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:15 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpPUt017320
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:26 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

For architecture dependent compat syscalls in common code an architecture
must define something like __ARCH_WANT_<WHATEVER> if it wants to use the
code.
This however is not true for compat_sys_getdents64 for which architectures
must define __ARCH_OMIT_COMPAT_SYS_GETDENTS64 if they do not want the code.

This leads to the situation where all architectures, except mips, get the
compat code but only x86_64, arm64 and the generic syscall architectures
actually use it.

So invert the logic, so that architectures actively must do something to
get the compat code.

This way a couple of architectures get rid of otherwise dead code.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/arm64/include/asm/unistd.h   | 1 +
 arch/mips/include/asm/unistd.h    | 1 -
 arch/x86/include/asm/unistd.h     | 1 +
 fs/compat.c                       | 4 ++--
 include/linux/compat.h            | 2 ++
 include/uapi/asm-generic/unistd.h | 1 +
 6 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 82ce217e94cf..a4654c656a1e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -14,6 +14,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #ifdef CONFIG_COMPAT
+#define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 4d3b92886665..413d6c612bec 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -24,7 +24,6 @@
 
 #ifndef __ASSEMBLY__
 
-#define __ARCH_OMIT_COMPAT_SYS_GETDENTS64
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index c2a48139c340..f4b5795d7e34 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -23,6 +23,7 @@
 #  include <asm/unistd_64.h>
 #  include <asm/unistd_64_x32.h>
 #  define __ARCH_WANT_COMPAT_SYS_TIME
+#  define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 
 # endif
 
diff --git a/fs/compat.c b/fs/compat.c
index 6af20de2c1a3..0095a6978eef 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -981,7 +981,7 @@ asmlinkage long compat_sys_getdents(unsigned int fd,
 	return error;
 }
 
-#ifndef __ARCH_OMIT_COMPAT_SYS_GETDENTS64
+#ifdef __ARCH_WANT_COMPAT_SYS_GETDENTS64
 
 struct compat_getdents_callback64 {
 	struct dir_context ctx;
@@ -1066,7 +1066,7 @@ asmlinkage long compat_sys_getdents64(unsigned int fd,
 	fdput(f);
 	return error;
 }
-#endif /* ! __ARCH_OMIT_COMPAT_SYS_GETDENTS64 */
+#endif /* __ARCH_WANT_COMPAT_SYS_GETDENTS64 */
 
 /*
  * Exactly like fs/open.c:sys_open(), except that it doesn't set the
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 3f448c65511b..beded18f992d 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -502,9 +502,11 @@ asmlinkage long compat_sys_old_readdir(unsigned int fd,
 asmlinkage long compat_sys_getdents(unsigned int fd,
 				    struct compat_linux_dirent __user *dirent,
 				    unsigned int count);
+#ifdef __ARCH_WANT_COMPAT_SYS_GETDENTS64
 asmlinkage long compat_sys_getdents64(unsigned int fd,
 				      struct linux_dirent64 __user *dirent,
 				      unsigned int count);
+#endif
 asmlinkage long compat_sys_vmsplice(int fd, const struct compat_iovec __user *,
 				    unsigned int nr_segs, unsigned int flags);
 asmlinkage long compat_sys_open(const char __user *filename, int flags,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dde8041f40d2..6db66783d268 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -191,6 +191,7 @@ __SYSCALL(__NR_quotactl, sys_quotactl)
 
 /* fs/readdir.c */
 #define __NR_getdents64 61
+#define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 __SC_COMP(__NR_getdents64, sys_getdents64, compat_sys_getdents64)
 
 /* fs/read_write.c */
-- 
1.8.4.5
