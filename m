Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:36881 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941AbbCEB3J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Mar 2015 20:29:09 -0500
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 3/8] microblaze: use asm-generic for seccomp.h
Date: Wed,  4 Mar 2015 17:27:03 -0800
Message-ID: <1425518828-16017-4-git-send-email-keescook@chromium.org>
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Daniel Borkmann <dborkman@redhat.com>, Laura Abbott <lauraa@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150305012703.Oj9JgSye13qVd1iNEzDFDaLUXWWV2OQGXG9_RqEBgOM@z>

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. Since microblaze is 32-bit, the COMPAT
seccomp defines are unused and can be dropped. The obsolete sigreturn
for seccomp strict mode is retained as an override. Remaining definitions
are identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/microblaze/include/asm/seccomp.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/seccomp.h b/arch/microblaze/include/asm/seccomp.h
index 0d912758a0d7..204618a2ce84 100644
--- a/arch/microblaze/include/asm/seccomp.h
+++ b/arch/microblaze/include/asm/seccomp.h
@@ -3,14 +3,8 @@
 
 #include <linux/unistd.h>
 
-#define __NR_seccomp_read		__NR_read
-#define __NR_seccomp_write		__NR_write
-#define __NR_seccomp_exit		__NR_exit
 #define __NR_seccomp_sigreturn		__NR_sigreturn
 
-#define __NR_seccomp_read_32		__NR_read
-#define __NR_seccomp_write_32		__NR_write
-#define __NR_seccomp_exit_32		__NR_exit
-#define __NR_seccomp_sigreturn_32	__NR_sigreturn
+#include <asm-generic/seccomp.h>
 
 #endif	/* _ASM_MICROBLAZE_SECCOMP_H */
-- 
1.9.1

