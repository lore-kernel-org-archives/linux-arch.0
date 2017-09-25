From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 1/3] compat ABI: use non-compat openat and open_by_handle_at variants
Date: Tue, 26 Sep 2017 00:00:33 +0300
Message-ID: <20170925210035.31514-2-ynorov@caviumnetworks.com>
References: <20170925210035.31514-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:57472
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964935AbdIYVBE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Sep 2017 17:01:04 -0400
In-Reply-To: <20170925210035.31514-1-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>

The only difference is that non-compat version forces O_LARGEFILE,
and it should be the default behaviour for all architectures, as
we are going to drop the support of 32-bit userspace off_t.

The exception is tile32 that continues with compat version of syscalls.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Chris Metcalf <cmetcalf@ezchip.com> [for tile]
---
 arch/tile/kernel/compat.c         | 3 +++
 include/uapi/asm-generic/unistd.h | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
index bdaf71d31a4a..3b7853c59395 100644
--- a/arch/tile/kernel/compat.c
+++ b/arch/tile/kernel/compat.c
@@ -103,6 +103,9 @@ COMPAT_SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned int, offset_high,
 #define compat_sys_readahead sys32_readahead
 #define sys_llseek compat_sys_llseek
 
+#define sys_openat		compat_sys_openat
+#define sys_open_by_handle_at	compat_sys_open_by_handle_at
+
 /* Call the assembly trampolines where necessary. */
 #define compat_sys_rt_sigreturn _compat_sys_rt_sigreturn
 #define sys_clone _sys_clone
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 061185a5eb51..429dd335def6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -178,7 +178,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -675,8 +675,7 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
 #define __NR_clock_adjtime 266
 __SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
 #define __NR_syncfs 267
-- 
2.11.0
