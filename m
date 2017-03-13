From: Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2] generic syscalls: Wire up statx syscall
Date: Mon, 13 Mar 2017 23:45:21 +0900
Message-ID: <20170313144521.28127-1-shorne@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stafford Horne <shorne@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The new syscall statx is implemented as generic code, so enable it
for architectures like openrisc which use the generic syscall table.

Fixes: a528d35e8bfcc ("statx: Add a system call to make enhanced file info available")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Change in v2:
 - Add a few more Cc's to get attention of the right people
 - Add a fixes tag for better audit

 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 9b1462e..a076cf1 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -730,9 +730,11 @@ __SYSCALL(__NR_pkey_mprotect, sys_pkey_mprotect)
 __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 #define __NR_pkey_free 290
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
+#define __NR_statx 291
+__SYSCALL(__NR_statx,     sys_statx)
 
 #undef __NR_syscalls
-#define __NR_syscalls 291
+#define __NR_syscalls 292
 
 /*
  * All syscalls below here should go away really,
-- 
2.9.3
