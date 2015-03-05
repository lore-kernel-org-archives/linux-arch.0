Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:48058 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbbCEB3C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Mar 2015 20:29:02 -0500
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 1/8] seccomp: allow COMPAT sigreturn overrides
Date: Wed,  4 Mar 2015 17:27:01 -0800
Message-ID: <1425518828-16017-2-git-send-email-keescook@chromium.org>
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Daniel Borkmann <dborkman@redhat.com>, Laura Abbott <lauraa@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150305012701.83JMIsVKbP7uAZFax4CTih2kvr0glrcBDj_jv3r67Cc@z>

Some architectures may need to override the compat sigreturn definition,
as is already possible in the non-compat case.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/seccomp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/seccomp.h b/include/asm-generic/seccomp.h
index 9fa1f653ed3b..c9ccafa0d99a 100644
--- a/include/asm-generic/seccomp.h
+++ b/include/asm-generic/seccomp.h
@@ -17,7 +17,9 @@
 #define __NR_seccomp_read_32		__NR_read
 #define __NR_seccomp_write_32		__NR_write
 #define __NR_seccomp_exit_32		__NR_exit
+#ifndef __NR_seccomp_sigreturn_32
 #define __NR_seccomp_sigreturn_32	__NR_rt_sigreturn
+#endif
 #endif /* CONFIG_COMPAT && ! already defined */
 
 #define __NR_seccomp_read		__NR_read
-- 
1.9.1

