From: Chris Metcalf <cmetcalf@tilera.com>
Subject: [PATCH] asm-generic/unistd.h: support sendmmsg syscall
Date: Thu, 2 Jun 2011 14:21:45 -0400
Message-ID: <201106021826.p52IQQSG032352@farm-0012.internal.tilera.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
---
I'll ask Linus to pull this for 3.0.

 include/asm-generic/unistd.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
index ae90e0f..4f76959 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -683,9 +683,11 @@ __SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_setns 268
 __SYSCALL(__NR_setns, sys_setns)
+#define __NR_sendmmsg 269
+__SC_COMP(__NR_sendmmsg, sys_sendmmsg, compat_sys_sendmmsg)
 
 #undef __NR_syscalls
-#define __NR_syscalls 269
+#define __NR_syscalls 270
 
 /*
  * All syscalls below here should go away really,
-- 
1.6.5.2
