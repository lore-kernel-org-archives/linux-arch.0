Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:59398 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbeC2L0V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:21 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 060/109] fs: add do_compat_signalfd4() helper; remove in-kernel call to compat syscall
Date: Thu, 29 Mar 2018 13:23:37 +0200
Message-ID: <20180329112426.23043-61-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180329112337.YWqpOeQPj1UlGKlucueB4N_95PC4uZFFfBAG-qvoYEw@z>

Using the fs-internal do_compat_signalfd4() helper allows us to get rid of
the fs-internal call to the compat_sys_signalfd4() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/signalfd.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 501c41f3351f..d2187a813376 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -323,10 +323,9 @@ SYSCALL_DEFINE3(signalfd, int, ufd, sigset_t __user *, user_mask,
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE4(signalfd4, int, ufd,
-		     const compat_sigset_t __user *,sigmask,
-		     compat_size_t, sigsetsize,
-		     int, flags)
+static long do_compat_signalfd4(int ufd,
+			const compat_sigset_t __user *sigmask,
+			compat_size_t sigsetsize, int flags)
 {
 	sigset_t tmp;
 	sigset_t __user *ksigmask;
@@ -342,10 +341,18 @@ COMPAT_SYSCALL_DEFINE4(signalfd4, int, ufd,
 	return do_signalfd4(ufd, ksigmask, sizeof(sigset_t), flags);
 }
 
+COMPAT_SYSCALL_DEFINE4(signalfd4, int, ufd,
+		     const compat_sigset_t __user *, sigmask,
+		     compat_size_t, sigsetsize,
+		     int, flags)
+{
+	return do_compat_signalfd4(ufd, sigmask, sigsetsize, flags);
+}
+
 COMPAT_SYSCALL_DEFINE3(signalfd, int, ufd,
 		     const compat_sigset_t __user *,sigmask,
 		     compat_size_t, sigsetsize)
 {
-	return compat_sys_signalfd4(ufd, sigmask, sigsetsize, 0);
+	return do_compat_signalfd4(ufd, sigmask, sigsetsize, 0);
 }
 #endif
-- 
2.16.3
