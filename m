Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:46417 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbbCEB3C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Mar 2015 20:29:02 -0500
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 4/8] mips: switch to using asm-generic for seccomp.h
Date: Wed,  4 Mar 2015 17:27:04 -0800
Message-ID: <1425518828-16017-5-git-send-email-keescook@chromium.org>
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Daniel Borkmann <dborkman@redhat.com>, Laura Abbott <lauraa@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150305012704.C7qdKe0hRQh0yu2SLNEkb5sfaq_I8YUWLbmlJMLexLU@z>

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. COMPAT definitions retain their overrides
and the remaining definitions were identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/include/asm/seccomp.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/seccomp.h b/arch/mips/include/asm/seccomp.h
index f29c75cf83c6..1d8a2e2c75c1 100644
--- a/arch/mips/include/asm/seccomp.h
+++ b/arch/mips/include/asm/seccomp.h
@@ -2,11 +2,6 @@
 
 #include <linux/unistd.h>
 
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
 /*
  * Kludge alert:
  *
@@ -29,4 +24,6 @@
 
 #endif /* CONFIG_MIPS32_O32 */
 
+#include <asm-generic/seccomp.h>
+
 #endif /* __ASM_SECCOMP_H */
-- 
1.9.1

