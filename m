From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 7/8] sparc: switch to using asm-generic for seccomp.h
Date: Wed,  4 Mar 2015 17:27:07 -0800
Message-ID: <1425518828-16017-8-git-send-email-keescook@chromium.org>
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
strict mode syscall definitions. The obsolete sigreturn in COMPAT mode
is retained as an override. Remaining definitions are identical. Also
corrected missing #define for header reinclusion protection.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/include/asm/seccomp.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/seccomp.h b/arch/sparc/include/asm/seccomp.h
index adca1bce41d4..5ef8826d44f8 100644
--- a/arch/sparc/include/asm/seccomp.h
+++ b/arch/sparc/include/asm/seccomp.h
@@ -1,15 +1,10 @@
 #ifndef _ASM_SECCOMP_H
+#define _ASM_SECCOMP_H
 
 #include <linux/unistd.h>
 
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
 #define __NR_seccomp_sigreturn_32 __NR_sigreturn
 
+#include <asm-generic/seccomp.h>
+
 #endif /* _ASM_SECCOMP_H */
-- 
1.9.1
