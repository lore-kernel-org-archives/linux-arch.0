From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 41/45] x86: remove compat_sys_x86_waitpid()
Date: Thu, 22 Mar 2018 10:00:55 +0100
Message-ID: <20180322090059.19361-42-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

compat_sys_x86_waitpid() is not needed, as it takes the same parameters
(int, *int, int) as the native syscall.

Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 2 +-
 arch/x86/ia32/sys_ia32.c               | 6 ------
 arch/x86/include/asm/sys_ia32.h        | 3 ---
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 09338dd2bd94..c58f75b088c5 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -13,7 +13,7 @@
 4	i386	write			sys_write
 5	i386	open			sys_open			compat_sys_open
 6	i386	close			sys_close
-7	i386	waitpid			sys_waitpid			compat_sys_x86_waitpid
+7	i386	waitpid			sys_waitpid
 8	i386	creat			sys_creat
 9	i386	link			sys_link
 10	i386	unlink			sys_unlink
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index b9d4d8abc3f7..bd8a7020b9a7 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -170,12 +170,6 @@ COMPAT_SYSCALL_DEFINE1(x86_mmap, struct mmap_arg_struct32 __user *, arg)
 			       a.offset>>PAGE_SHIFT);
 }
 
-COMPAT_SYSCALL_DEFINE3(x86_waitpid, compat_pid_t, pid, unsigned int __user *,
-		       stat_addr, int, options)
-{
-	return compat_sys_wait4(pid, stat_addr, options, NULL);
-}
-
 /* warning: next two assume little endian */
 COMPAT_SYSCALL_DEFINE5(x86_pread, unsigned int, fd, char __user *, ubuf,
 		       u32, count, u32, poslo, u32, poshi)
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index 906794aa034e..2ee6e3b96656 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -35,9 +35,6 @@ asmlinkage long compat_sys_x86_fstatat(unsigned int, const char __user *,
 struct mmap_arg_struct32;
 asmlinkage long compat_sys_x86_mmap(struct mmap_arg_struct32 __user *);
 
-asmlinkage long compat_sys_x86_waitpid(compat_pid_t, unsigned int __user *,
-				       int);
-
 asmlinkage long compat_sys_x86_pread(unsigned int, char __user *, u32, u32,
 				     u32);
 asmlinkage long compat_sys_x86_pwrite(unsigned int, const char __user *, u32,
-- 
2.16.2
