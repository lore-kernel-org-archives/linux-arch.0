From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/13] Use sys_ni.c instead of #ifdef to disable fork on CONFIG_NOMMU
Date: Tue,  3 Nov 2015 11:46:23 -0800
Message-ID: <1446579994-9937-3-git-send-email-palmer__8345.42565648935$1446580211$gmane$org@dabbelt.com>
References: <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
 <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36507 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435AbbKCTqt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2015 14:46:49 -0500
Received: by pacdm15 with SMTP id dm15so2818868pac.3
        for <linux-arch@vger.kernel.org>; Tue, 03 Nov 2015 11:46:48 -0800 (PST)
In-Reply-To: <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, dhowells@redhat.com
Cc: viro@zeniv.linux.org.uk, ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net, dyoung@redhat.com, drysdale@google.com, davem@davemloft.net, ebiederm@xmission.com, geoff@infradead.org, gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org, josh@joshtriplett.org, kexec@lists.infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>

I think this change actually doesn't do anything: __NR_fork was still
being defined either way, and on my machine fork() in <unistd.h> comes
from libc.

This just moves to the standard mechanism for defining syscalls that
aren't implemented instead, which has the side-effect of no longer
having an #ifdef CONFIG_* in a user-visible header.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/asm-generic/unistd.h | 4 ----
 kernel/sys_ni.c                   | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index ee12400..ffd2957 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -869,11 +869,7 @@ __SYSCALL(__NR_uselib, sys_uselib)
 __SYSCALL(__NR__sysctl, sys_sysctl)
 
 #define __NR_fork 1079
-#ifdef CONFIG_MMU
 __SYSCALL(__NR_fork, sys_fork)
-#else
-__SYSCALL(__NR_fork, sys_ni_syscall)
-#endif /* CONFIG_MMU */
 
 #undef __NR_syscalls
 #define __NR_syscalls (__NR_fork+1)
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index a02decf..c830f7f 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -174,6 +174,7 @@ cond_syscall(sys_setfsuid);
 cond_syscall(sys_setfsgid);
 cond_syscall(sys_capget);
 cond_syscall(sys_capset);
+cond_syscall(sys_fork);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
-- 
2.4.10
