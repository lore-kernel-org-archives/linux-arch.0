From: Wang Chen <wangchen@cn.fujitsu.com>
Subject: [PATCH] flag parameters: fix compile error of sys_epoll_create1
Date: Fri, 25 Jul 2008 15:44:33 +0800
Message-ID: <48898461.4070603@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:57433 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbYGYHqT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Jul 2008 03:46:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Davide Libenzi <davidel@xmailserver.org>, Ulrich Drepper <drepper@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
arch/x86/kernel/built-in.o: In function `sys_call_table':
(.rodata+0x8a4): undefined reference to `sys_epoll_create1'
make: *** [vmlinux] Error 1

Signed-off-by: Wang Chen <wangchen@cn.fujitsu.com>
Cc: Ulrich Drepper <drepper@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-arch@vger.kernel.org>
---
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index bd66ac5..55eca15 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -57,6 +57,7 @@ cond_syscall(compat_sys_set_robust_list);
 cond_syscall(sys_get_robust_list);
 cond_syscall(compat_sys_get_robust_list);
 cond_syscall(sys_epoll_create);
+cond_syscall(sys_epoll_create1);
 cond_syscall(sys_epoll_ctl);
 cond_syscall(sys_epoll_wait);
 cond_syscall(sys_epoll_pwait);
