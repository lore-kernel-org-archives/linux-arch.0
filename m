Return-Path: <SRS0=Ax4L=7D=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Date: Thu, 21 May 2020 14:17:20 -0700
Message-ID: <20200521211720.20236-6-yu-cheng.yu@intel.com>
In-Reply-To: <20200521211720.20236-1-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200521211720.oZTmNS4ZgehKnqwLr5olvAK002upyTP7XiLAUnK9-Lg@z>

Introduce a quick test to verify shadow stack and IBT are working.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 tools/testing/selftests/x86/Makefile         |   2 +-
 tools/testing/selftests/x86/cet_quick_test.c | 128 +++++++++++++++++++
 2 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/cet_quick_test.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftes=
ts/x86/Makefile
index f1bf5ab87160..26e68272117a 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -14,7 +14,7 @@ CAN_BUILD_CET :=3D $(shell ./check_cc.sh $(CC) trivial_=
program.c -fcf-protection)
 TARGETS_C_BOTHBITS :=3D single_step_syscall sysret_ss_attrs syscall_nt t=
est_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			protection_keys test_vdso test_vsyscall mov_ss_trap \
-			syscall_arg_fault
+			syscall_arg_fault cet_quick_test
 TARGETS_C_32BIT_ONLY :=3D entry_from_vm86 test_syscall_vdso unwind_vdso =
\
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/cet_quick_test.c b/tools/testing=
/selftests/x86/cet_quick_test.c
new file mode 100644
index 000000000000..e84bbbcfd26f
--- /dev/null
+++ b/tools/testing/selftests/x86/cet_quick_test.c
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Quick tests to verify Shadow Stack and IBT are working */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <ucontext.h>
+
+ucontext_t ucp;
+int result[4] =3D {-1, -1, -1, -1};
+int test_id;
+
+void stack_hacked(unsigned long x)
+{
+	result[test_id] =3D -1;
+	test_id++;
+	setcontext(&ucp);
+}
+
+#pragma GCC push_options
+#pragma GCC optimize ("O0")
+void ibt_violation(void)
+{
+#ifdef __i386__
+	asm volatile("lea 1f, %eax");
+	asm volatile("jmp *%eax");
+#else
+	asm volatile("lea 1f, %rax");
+	asm volatile("jmp *%rax");
+#endif
+	asm volatile("1:");
+	result[test_id] =3D -1;
+	test_id++;
+	setcontext(&ucp);
+}
+
+void shstk_violation(void)
+{
+#ifdef __i386__
+	unsigned long x =3D 0;
+
+	((unsigned long *)&x)[2] =3D (unsigned long)stack_hacked;
+#else
+	unsigned long long x =3D 0;
+
+	((unsigned long long *)&x)[2] =3D (unsigned long)stack_hacked;
+#endif
+}
+#pragma GCC pop_options
+
+void segv_handler(int signum, siginfo_t *si, void *uc)
+{
+	result[test_id] =3D 0;
+	test_id++;
+	setcontext(&ucp);
+}
+
+void user1_handler(int signum, siginfo_t *si, void *uc)
+{
+	shstk_violation();
+}
+
+void user2_handler(int signum, siginfo_t *si, void *uc)
+{
+	ibt_violation();
+}
+
+int main(int argc, char *argv[])
+{
+	struct sigaction sa;
+	int r;
+
+	r =3D sigemptyset(&sa.sa_mask);
+	if (r)
+		return -1;
+
+	sa.sa_flags =3D SA_SIGINFO;
+
+	/*
+	 * Control protection fault handler
+	 */
+	sa.sa_sigaction =3D segv_handler;
+	r =3D sigaction(SIGSEGV, &sa, NULL);
+	if (r)
+		return -1;
+
+	/*
+	 * Handler to test Shadow stack
+	 */
+	sa.sa_sigaction =3D user1_handler;
+	r =3D sigaction(SIGUSR1, &sa, NULL);
+	if (r)
+		return -1;
+
+	/*
+	 * Handler to test IBT
+	 */
+	sa.sa_sigaction =3D user2_handler;
+	r =3D sigaction(SIGUSR2, &sa, NULL);
+	if (r)
+		return -1;
+
+	test_id =3D 0;
+	r =3D getcontext(&ucp);
+	if (r)
+		return -1;
+
+	if (test_id =3D=3D 0)
+		shstk_violation();
+	else if (test_id =3D=3D 1)
+		ibt_violation();
+	else if (test_id =3D=3D 2)
+		raise(SIGUSR1);
+	else if (test_id =3D=3D 3)
+		raise(SIGUSR2);
+
+	r =3D 0;
+	printf("[%s]\tShadow stack\n", result[0] ? "FAIL":"OK");
+	r +=3D result[0];
+	printf("[%s]\tIBT\n", result[1] ? "FAIL":"OK");
+	r +=3D result[1];
+	printf("[%s]\tShadow stack in signal\n", result[2] ? "FAIL":"OK");
+	r +=3D result[2];
+	printf("[%s]\tIBT in signal\n", result[3] ? "FAIL":"OK");
+	r +=3D result[3];
+	return r;
+}
--=20
2.21.0
