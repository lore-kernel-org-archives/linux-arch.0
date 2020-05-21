Return-Path: <SRS0=Ax4L=7D=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH 2/5] selftest/x86: Enable CET for selftests/x86
Date: Thu, 21 May 2020 14:17:17 -0700
Message-ID: <20200521211720.20236-3-yu-cheng.yu@intel.com>
In-Reply-To: <20200521211720.20236-1-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200521211717.Ym0Hk2skpP_0LCFGUPzZmxiiuw9W7atoGJhmP9pZhqM@z>

To build CET-enabled applications, GCC needs to support '-fcf-protection'=
.
Update x86 selftest makefile to detect and enable CET for x86 selftest
applications.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 tools/testing/selftests/x86/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftes=
ts/x86/Makefile
index 5d49bfec1e9a..f1bf5ab87160 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -9,6 +9,7 @@ UNAME_M :=3D $(shell uname -m)
 CAN_BUILD_I386 :=3D $(shell ./check_cc.sh $(CC) trivial_32bit_program.c =
-m32)
 CAN_BUILD_X86_64 :=3D $(shell ./check_cc.sh $(CC) trivial_64bit_program.=
c)
 CAN_BUILD_WITH_NOPIE :=3D $(shell ./check_cc.sh $(CC) trivial_program.c =
-no-pie)
+CAN_BUILD_CET :=3D $(shell ./check_cc.sh $(CC) trivial_program.c -fcf-pr=
otection)
=20
 TARGETS_C_BOTHBITS :=3D single_step_syscall sysret_ss_attrs syscall_nt t=
est_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
@@ -35,6 +36,10 @@ BINARIES_64 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_6=
4))
=20
 CFLAGS :=3D -O2 -g -std=3Dgnu99 -pthread -Wall
=20
+ifeq ($(CAN_BUILD_CET),1)
+CFLAGS +=3D -fcf-protection -mshstk
+endif
+
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS +=3D -no-pie
--=20
2.21.0
