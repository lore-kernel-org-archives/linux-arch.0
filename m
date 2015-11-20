From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM64: fix building without CONFIG_UID16
Date: Fri, 20 Nov 2015 12:12:21 +0100
Message-ID: <3891403.6hGat7eHq5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

As reported by Michal Simek, building an ARM64 kernel with CONFIG_UID16
disabled currently fails because the system call table still needs to
reference the individual function entry points that are provided by
kernel/sys_ni.c in this case, and the declarations are hidden inside
of #ifdef CONFIG_UID16:

arch/arm64/include/asm/unistd32.h:57:8: error: 'sys_lchown16' undeclared here (not in a function)
 __SYSCALL(__NR_lchown, sys_lchown16)

I believe this problem only exists on ARM64, because older architectures
tend to not need declarations when their system call table is built
in assembly code, while newer architectures tend to not need UID16
support. ARM64 only uses these system calls for compatibility with
32-bit ARM binaries.

This changes the CONFIG_UID16 check into CONFIG_HAVE_UID16, which is
set unconditionally on ARM64 with CONFIG_COMPAT, so we see the
declarations whenever we need them, but otherwise the behavior is
unchanged.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
Fixes: af1839eb4bd4 ("Kconfig: clean up the long arch list for the UID16 config option")
---
I would suggest merging this through the arm64 tree, as this is
likely the only architecture that cares about it, and there is little
risk of clashes with other patches in the global headers.

The bug goes back to when arch/arm64 was introduced as far as I can
tell, but I'm not sure if we care about stable backports or not.
I've put stable on Cc anyway, let me know if anyone thinks we should not.

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a156b82dd14c..c2b66a277e98 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -524,7 +524,7 @@ asmlinkage long sys_chown(const char __user *filename,
 asmlinkage long sys_lchown(const char __user *filename,
 				uid_t user, gid_t group);
 asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
-#ifdef CONFIG_UID16
+#ifdef CONFIG_HAVE_UID16
 asmlinkage long sys_chown16(const char __user *filename,
 				old_uid_t user, old_gid_t group);
 asmlinkage long sys_lchown16(const char __user *filename,
diff --git a/include/linux/types.h b/include/linux/types.h
index 70d8500bddf1..70dd3dfde631 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -35,7 +35,7 @@ typedef __kernel_gid16_t        gid16_t;
 
 typedef unsigned long		uintptr_t;
 
-#ifdef CONFIG_UID16
+#ifdef CONFIG_HAVE_UID16
 /* This is defined by include/asm-{arch}/posix_types.h */
 typedef __kernel_old_uid_t	old_uid_t;
 typedef __kernel_old_gid_t	old_gid_t;
