From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 040/109] kernel: add do_getpgid() helper; remove internal call to sys_getpgid()
Date: Thu, 29 Mar 2018 13:23:17 +0200
Message-ID: <20180329112426.23043-41-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using the do_getpgid() helper removes an in-kernel call to the
sys_getpgid() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/sys.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index f2289de20e19..ebb138b841c8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1027,7 +1027,7 @@ SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)
 	return err;
 }
 
-SYSCALL_DEFINE1(getpgid, pid_t, pid)
+static int do_getpgid(pid_t pid)
 {
 	struct task_struct *p;
 	struct pid *grp;
@@ -1055,11 +1055,16 @@ SYSCALL_DEFINE1(getpgid, pid_t, pid)
 	return retval;
 }
 
+SYSCALL_DEFINE1(getpgid, pid_t, pid)
+{
+	return do_getpgid(pid);
+}
+
 #ifdef __ARCH_WANT_SYS_GETPGRP
 
 SYSCALL_DEFINE0(getpgrp)
 {
-	return sys_getpgid(0);
+	return do_getpgid(0);
 }
 
 #endif
-- 
2.16.3
