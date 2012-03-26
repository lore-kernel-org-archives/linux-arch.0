From: Chris Metcalf <cmetcalf@tilera.com>
Subject: [PATCH] compat: use sys_sendfile64() implementation for sendfile syscall
Date: Mon, 26 Mar 2012 16:26:12 -0400
Message-ID: <201203262036.q2QKaZ7U009929@farm-0012.internal.tilera.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

<asm-generic/unistd.h> was set up to use sys_sendfile() for the 32-bit
compat API instead of sys_sendfile64(), but in fact the right thing to
do is to use sys_sendfile64() in all cases.  The 32-bit sendfile64() API
in glibc uses the sendfile64 syscall, so it has to be capable of doing
full 64-bit operations.  But the sys_sendfile() kernel implementation
has a MAX_NON_LFS test in it which explicitly limits the offset to 2^32.
So, we need to use the sys_sendfile64() implementation in the kernel
for this case.

Cc: <stable@kernel.org>
Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
---
 include/asm-generic/unistd.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
index 2292d1a..991ef01 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -218,7 +218,7 @@ __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
 
 /* fs/sendfile.c */
 #define __NR3264_sendfile 71
-__SC_3264(__NR3264_sendfile, sys_sendfile64, sys_sendfile)
+__SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
 /* fs/select.c */
 #define __NR_pselect6 72
-- 
1.6.5.2
