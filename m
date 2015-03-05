From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 2/8] arm: use asm-generic for seccomp.h
Date: Wed,  4 Mar 2015 17:27:02 -0800
Message-ID: <1425518828-16017-3-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: akpm@linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Daniel Borkmann <dborkman@redhat.com>, Laura Abbott <lauraa@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.
List-Id: linux-arch.vger.kernel.org

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. Definitions were identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/Kbuild    |  1 +
 arch/arm/include/asm/seccomp.h | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)
 delete mode 100644 arch/arm/include/asm/seccomp.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index fe74c0d1e485..d7be5a9fd171 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -22,6 +22,7 @@ generic-y += preempt.h
 generic-y += resource.h
 generic-y += rwsem.h
 generic-y += scatterlist.h
+generic-y += seccomp.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += sembuf.h
diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccomp.h
deleted file mode 100644
index 52b156b341f5..000000000000
--- a/arch/arm/include/asm/seccomp.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _ASM_ARM_SECCOMP_H
-#define _ASM_ARM_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#endif /* _ASM_ARM_SECCOMP_H */
-- 
1.9.1
