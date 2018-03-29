Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:59048 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbeC2L02 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:28 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 041/109] kernel: add do_compat_sigaltstack() helper; remove in-kernel call to compat syscall
Date: Thu, 29 Mar 2018 13:23:18 +0200
Message-ID: <20180329112426.23043-42-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180329112318.YbALa_kL3TGi5XYMqb5849zmI-YTgcSAvwM8vhFNRxM@z>

Using this helper allows us to avoid the in-kernel call to the
compat_sys_sigaltstack() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/signal.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 985c61749bcf..f04466655238 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3573,9 +3573,8 @@ int __save_altstack(stack_t __user *uss, unsigned long sp)
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(sigaltstack,
-			const compat_stack_t __user *, uss_ptr,
-			compat_stack_t __user *, uoss_ptr)
+static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
+				 compat_stack_t __user *uoss_ptr)
 {
 	stack_t uss, uoss;
 	int ret;
@@ -3602,9 +3601,16 @@ COMPAT_SYSCALL_DEFINE2(sigaltstack,
 	return ret;
 }
 
+COMPAT_SYSCALL_DEFINE2(sigaltstack,
+			const compat_stack_t __user *, uss_ptr,
+			compat_stack_t __user *, uoss_ptr)
+{
+	return do_compat_sigaltstack(uss_ptr, uoss_ptr);
+}
+
 int compat_restore_altstack(const compat_stack_t __user *uss)
 {
-	int err = compat_sys_sigaltstack(uss, NULL);
+	int err = do_compat_sigaltstack(uss, NULL);
 	/* squash all but -EFAULT for now */
 	return err == -EFAULT ? err : 0;
 }
-- 
2.16.3
