From: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 3/5] selftest/x86: Fix sigreturn_64 test.
Date: Thu, 21 May 2020 14:17:18 -0700
Message-ID: <20200521211720.20236-4-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200521211720.20236-1-yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

When shadow stack is enabled, selftests/x86/sigreturn_64 triggers a fault
when doing sigreturn to 32-bit context but the task's shadow stack pointer
is above 32-bit address range.  Fix it by:

- Allocate a small shadow stack below 32-bit address,
- Switch to the new shadow stack,
- Run tests,
- Switch back to the original 64-bit shadow stack.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 tools/testing/selftests/x86/sigreturn.c | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 57c4f67f16ef..5bcd74d416ff 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -45,6 +45,14 @@
 #include <stdbool.h>
 #include <sys/ptrace.h>
 #include <sys/user.h>
+#include <x86intrin.h>
+#include <asm/prctl.h>
+#include <sys/prctl.h>
+
+#ifdef __x86_64__
+int arch_prctl(int code, unsigned long *addr);
+#define ARCH_CET_ALLOC_SHSTK 0x3004
+#endif
 
 /* Pull in AR_xyz defines. */
 typedef unsigned int u32;
@@ -766,6 +774,20 @@ int main()
 	int total_nerrs = 0;
 	unsigned short my_cs, my_ss;
 
+#ifdef __x86_64__
+	/* Alloc a shadow stack within 32-bit address range */
+	unsigned long arg, ssp_64, ssp_32;
+	ssp_64 = _get_ssp();
+
+	if (ssp_64 != 0) {
+		arg = 0x1001;
+		arch_prctl(ARCH_CET_ALLOC_SHSTK, &arg);
+		ssp_32 = arg + 0x1000 - 8;
+		asm volatile("RSTORSSP (%0)\n":: "r" (ssp_32));
+		asm volatile("SAVEPREVSSP");
+	}
+#endif
+
 	asm volatile ("mov %%cs,%0" : "=r" (my_cs));
 	asm volatile ("mov %%ss,%0" : "=r" (my_ss));
 	setup_ldt();
@@ -870,6 +892,12 @@ int main()
 
 #ifdef __x86_64__
 	total_nerrs += test_nonstrict_ss();
+
+	if (ssp_64 != 0) {
+		ssp_64 -= 8;
+		asm volatile("RSTORSSP (%0)\n":: "r" (ssp_64));
+		asm volatile("SAVEPREVSSP");
+	}
 #endif
 
 	return total_nerrs ? 1 : 0;
-- 
2.21.0
