From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: [PATCH 1/1] Add new syscall sys_sendmmsg to generic unistd
Date: Sat, 28 May 2011 22:19:29 +0200
Message-ID: <1306613969-9426-1-git-send-email-jonas.bonn@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:39386 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1E1UhP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 May 2011 16:37:15 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: arnd@arndb.de, Jonas Bonn <jonas@southpole.se>


From: Jonas Bonn <jonas@southpole.se>

This enables the syscall for architectures, like OpenRISC, that use the
generic asm headers.

Signed-off-by: Jonas Bonn <jonas@southpole.se>
---
 include/asm-generic/unistd.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
index 6b5bfb5..e4c7366 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -681,9 +681,11 @@ __SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
 __SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
 #define __NR_syncfs 267
 __SYSCALL(__NR_syncfs, sys_syncfs)
+#define __NR_sendmmsg 268
+__SC_COMP(__NR_sendmmsg, sys_sendmmsg, compat_sys_sendmmsg)
 
 #undef __NR_syscalls
-#define __NR_syscalls 268
+#define __NR_syscalls 269
 
 /*
  * All syscalls below here should go away really,
-- 
1.7.4.1
