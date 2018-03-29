From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 006/109] x86: use _do_fork() in compat_sys_x86_clone()
Date: Thu, 29 Mar 2018 13:22:43 +0200
Message-ID: <20180329112426.23043-7-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

It is trivial to directly call _do_fork() instead of the sys_clone()
syscall in compat_sys_x86_clone().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: x86@kernel.org
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/ia32/sys_ia32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 6512498bbef6..aa024a2dd34f 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -41,6 +41,7 @@
 #include <linux/highuid.h>
 #include <linux/sysctl.h>
 #include <linux/slab.h>
+#include <linux/sched/task.h>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <linux/uaccess.h>
@@ -241,6 +242,6 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
 		       unsigned long, newsp, int __user *, parent_tidptr,
 		       unsigned long, tls_val, int __user *, child_tidptr)
 {
-	return sys_clone(clone_flags, newsp, parent_tidptr, child_tidptr,
+	return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr,
 			tls_val);
 }
-- 
2.16.3
