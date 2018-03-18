From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH 5/6] x86: use _do_fork() in compat_sys_x86_clone()
Date: Sun, 18 Mar 2018 17:10:55 +0100
Message-ID: <20180318161056.5377-6-linux@dominikbrodowski.net>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318161056.5377-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

It is trivial to directly call _do_fork() instead of the sys_clone()
syscall in compat_sys_x86_clone().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/ia32/sys_ia32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 89dcb36d19da..31d50d11239b 100644
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
@@ -204,6 +205,6 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
 		       unsigned long, newsp, int __user *, parent_tidptr,
 		       unsigned long, tls_val, int __user *, child_tidptr)
 {
-	return sys_clone(clone_flags, newsp, parent_tidptr, child_tidptr,
+	return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr,
 			tls_val);
 }
-- 
2.16.2
