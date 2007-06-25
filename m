Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:57167 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbXFYIt0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 04:49:26 -0400
Subject: Introduce fixed sys_sync_file_range2() syscall, implement on
	PowerPC and ARM
From: David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 09:49:17 +0100
Message-Id: <1182761357.12109.14.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

Not all the world is an i386. Many architectures need 64-bit arguments
to be aligned in suitable pairs of registers, and the original
sys_sync_file_range(int, loff_t, loff_t, int) was therefore wasting an
argument register for padding after the first integer. Since we don't
normally have more than 6 arguments for system calls, that left no room
for the final argument on some architectures.

Fix this by introducing sys_sync_file_range2(int, int, loff_t, loff_t)
which all fits nicely. In fact, ARM already had that, but called it
sys_arm_sync_file_range. Move it to fs/sync.c and rename it, then
implement the needed compatibility routine. And stop the missing syscall
check from bitching about the absence of sys_sync_file_range() if we've
implemented sys_sync_file_range2() instead.

Tested on PPC32 and with 32-bit and 64-bit userspace on PPC64.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Acked-By: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 19326d7..a98d0c9 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -350,7 +350,7 @@
 		CALL(sys_set_robust_list)
 		CALL(sys_get_robust_list)
 /* 340 */	CALL(sys_splice)
-		CALL(sys_arm_sync_file_range)
+		CALL(sys_sync_file_range2)
 		CALL(sys_tee)
 		CALL(sys_vmsplice)
 		CALL(sys_move_pages)
diff --git a/arch/arm/kernel/sys_arm.c b/arch/arm/kernel/sys_arm.c
index 1ca2d51..4d25e49 100644
--- a/arch/arm/kernel/sys_arm.c
+++ b/arch/arm/kernel/sys_arm.c
@@ -328,16 +328,3 @@ asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
 {
 	return sys_fadvise64_64(fd, offset, len, advice);
 }
-
-/*
- * Yet more syscall fsckage - we can't fit sys_sync_file_range's
- * arguments into the available registers with EABI.  So, let's
- * create an ARM specific syscall for this which has _sane_
- * arguments.  (This incidentally also has an ABI-independent
- * argument layout.)
- */
-asmlinkage long sys_arm_sync_file_range(int fd, unsigned int flags,
-					loff_t offset, loff_t nbytes)
-{
-	return sys_sync_file_range(fd, offset, nbytes, flags);
-}
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 047246a..b42cbf1 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -810,3 +810,12 @@ asmlinkage long compat_sys_request_key(const char __user *_type,
 	return sys_request_key(_type, _description, _callout_info, destringid);
 }
 
+asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int flags,
+				   unsigned offset_hi, unsigned offset_lo,
+				   unsigned nbytes_hi, unsigned nbytes_lo)
+{
+	loff_t offset = ((loff_t)offset_hi << 32) | offset_lo;
+	loff_t nbytes = ((loff_t)nbytes_hi << 32) | nbytes_lo;
+
+	return sys_sync_file_range(fd, offset, nbytes, flags);
+}
diff --git a/fs/sync.c b/fs/sync.c
index 2f97576..7cd005e 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -236,6 +236,14 @@ out:
 	return ret;
 }
 
+/* It would be nice if people remember that not all the world's an i386
+   when they introduce new system calls */
+asmlinkage long sys_sync_file_range2(int fd, unsigned int flags,
+				     loff_t offset, loff_t nbytes)
+{
+	return sys_sync_file_range(fd, offset, nbytes, flags);
+}
+
 /*
  * `endbyte' is inclusive
  */
diff --git a/include/asm-arm/unistd.h b/include/asm-arm/unistd.h
index 250d7f1..bfdbebe 100644
--- a/include/asm-arm/unistd.h
+++ b/include/asm-arm/unistd.h
@@ -367,6 +367,7 @@
 #define __NR_get_robust_list		(__NR_SYSCALL_BASE+339)
 #define __NR_splice			(__NR_SYSCALL_BASE+340)
 #define __NR_arm_sync_file_range	(__NR_SYSCALL_BASE+341)
+#define __NR_sync_file_range2		__NR_arm_sync_file_range
 #define __NR_tee			(__NR_SYSCALL_BASE+342)
 #define __NR_vmsplice			(__NR_SYSCALL_BASE+343)
 #define __NR_move_pages			(__NR_SYSCALL_BASE+344)
diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 700ca59..1cc3f9c 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -311,3 +311,4 @@ COMPAT_SYS_SPU(utimensat)
 COMPAT_SYS_SPU(signalfd)
 COMPAT_SYS_SPU(timerfd)
 SYSCALL_SPU(eventfd)
+COMPAT_SYS_SPU(sync_file_range2)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index e3c28dc..f71c606 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -330,10 +330,11 @@
 #define __NR_signalfd		305
 #define __NR_timerfd		306
 #define __NR_eventfd		307
+#define __NR_sync_file_range2	308
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		308
+#define __NR_syscalls		309
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b02070e..83d0ec1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -598,6 +598,8 @@ asmlinkage long sys_tee(int fdin, int fdout, size_t len, unsigned int flags);
 
 asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 					unsigned int flags);
+asmlinkage long sys_sync_file_range2(int fd, unsigned int flags,
+				     loff_t offset, loff_t nbytes);
 asmlinkage long sys_get_robust_list(int pid,
 				    struct robust_list_head __user * __user *head_ptr,
 				    size_t __user *len_ptr);
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index f98171f..0dcc01c 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -99,6 +99,11 @@ cat << EOF
 #define __IGNORE_setfsuid32
 #define __IGNORE_setfsgid32
 
+/* sync_file_range had a stupid ABI. Allow sync_file_range2 instead */
+#ifdef __NR_sync_file_range2
+#define __IGNORE_sync_file_range
+#endif
+
 /* Unmerged syscalls for AFS, STREAMS, etc. */
 #define __IGNORE_afs_syscall
 #define __IGNORE_getpmsg


-- 
dwmw2

