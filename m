Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33021 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbbIIVIs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2015 17:08:48 -0400
Received: by pacex6 with SMTP id ex6so20874913pac.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2015 14:08:47 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/13] Always expose __SYSCALL(... fork ...)
Date: Wed,  9 Sep 2015 14:08:11 -0700
Message-ID: <1441832902-28993-3-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
References: <2644177.lVCYzIBfPW@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <20150909210811.G4LDaFgcENl_fnve2DBsyFBLMJXt5djDO9cHFONP-Ws@z>

I think this change actually doesn't do anything: __NR_fork was still
being defined either way, and on my machine fork() in <unistd.h> comes
from libc.

That said, I don't think there's any way to determine this
automatically, so this at least quiets the checker.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/asm-generic/unistd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index e016bd9b1a04..e027ef7aa01f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -865,11 +865,11 @@ __SYSCALL(__NR_uselib, sys_uselib)
 __SYSCALL(__NR__sysctl, sys_sysctl)
 
 #define __NR_fork 1079
-#ifdef CONFIG_MMU
+#if !defined(__KERNEL__) || defined(CONFIG_MMU)
 __SYSCALL(__NR_fork, sys_fork)
 #else
 __SYSCALL(__NR_fork, sys_ni_syscall)
-#endif /* CONFIG_MMU */
+#endif /* !__KERNEL__ || CONFIG_MMU */
 
 #undef __NR_syscalls
 #define __NR_syscalls (__NR_fork+1)
-- 
2.4.6

