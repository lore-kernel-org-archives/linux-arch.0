Return-Path: <SRS0=T8h9=7D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbgEUVRk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 17:17:40 -0400
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH 3/5] selftest/x86: Fix sigreturn_64 test.
Date: Thu, 21 May 2020 14:17:18 -0700
Message-ID: <20200521211720.20236-4-yu-cheng.yu@intel.com>
In-Reply-To: <20200521211720.20236-1-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20200521211718.GBDakspQRB2UYTF1EIYMZVJ4wH-rfp7NqbHozF_mgHY@z>

When shadow stack is enabled, selftests/x86/sigreturn_64 triggers a fault
when doing sigreturn to 32-bit context but the task's shadow stack pointer
is above 32-bit address range.  Fix it by:

- Allocate a small shadow stack below 32-bit address,
- Switch to the new shadow stack,
- Run tests,
- Switch back to the original 64-bit shadow stack.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
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
