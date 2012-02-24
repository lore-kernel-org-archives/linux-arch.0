Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:46961 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab2BXORR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Feb 2012 09:17:17 -0500
Message-ID: <4F47981F.4020305@imgtec.com>
Date: Fri, 24 Feb 2012 14:01:03 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: [RFC] [PATCH] asm-generic/unistd.h: handle symbol prefixes in cond_syscall
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20120224140103.Va0g0qCL4Xn61cWnJ7JGGDfe1Hzwb4LXxjeoZ2QZvBE@z>

Some architectures have symbol prefixes and set CONFIG_SYMBOL_PREFIX,
but this wasn't taken into account by the generic cond_syscall. It's
easy enough to fix in a generic fashion, so add the symbol prefix to
symbol names in cond_syscall when CONFIG_SYMBOL_PREFIX is set.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 include/asm-generic/unistd.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
index 2292d1a..c9a5ba4 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -924,7 +924,14 @@ __SYSCALL(__NR_fork, sys_ni_syscall)
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
+#ifdef CONFIG_SYMBOL_PREFIX
+#define __SYMBOL_PREFIX CONFIG_SYMBOL_PREFIX
+#else
+#define __SYMBOL_PREFIX
+#endif
+#define cond_syscall(x) asm(".weak\t" __SYMBOL_PREFIX #x "\n\t" \
+			    ".set\t" __SYMBOL_PREFIX #x "," \
+			    __SYMBOL_PREFIX "sys_ni_syscall")
 #endif
 
 #endif /* __KERNEL__ */
-- 
1.7.2.3


