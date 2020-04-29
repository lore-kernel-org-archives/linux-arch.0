Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 05/26] x86/cet/shstk: Add Kconfig option for user-mode Shadow Stack
Date: Wed, 29 Apr 2020 15:07:11 -0700
Message-ID: <20200429220732.31602-6-yu-cheng.yu@intel.com>
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429220711.JTJHKProke_-JBit7DKWupDLk6jV0p_5q3LhQif_AHo@z>

Shadow Stack provides protection against function return address
corruption.  It is active when the processor supports it, the kernel has
CONFIG_X86_INTEL_SHADOW_STACK_USER, and the application is built for the
feature.  This is only implemented for the 64-bit kernel.  When it is
enabled, legacy non-shadow stack applications continue to work, but witho=
ut
protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v10:
- Change SHSTK to shadow stack in the help text.
- Change build-time check to config-time check.
- Change ARCH_HAS_SHSTK to ARCH_HAS_SHADOW_STACK.

 arch/x86/Kconfig                      | 30 +++++++++++++++++++++++++++
 scripts/as-x86_64-has-shadow-stack.sh |  4 ++++
 2 files changed, 34 insertions(+)
 create mode 100755 scripts/as-x86_64-has-shadow-stack.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1197b5596d5a..c98f82fffe85 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1947,6 +1947,36 @@ config X86_INTEL_TSX_MODE_AUTO
 	  side channel attacks- equals the tsx=3Dauto command line parameter.
 endchoice
=20
+config AS_HAS_SHADOW_STACK
+	def_bool $(success,$(srctree)/scripts/as-x86_64-has-shadow-stack.sh $(C=
C))
+	help
+	  Test the assembler for shadow stack instructions.
+
+config X86_INTEL_CET
+	def_bool n
+
+config ARCH_HAS_SHADOW_STACK
+	def_bool n
+
+config X86_INTEL_SHADOW_STACK_USER
+	prompt "Intel Shadow Stacks for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	depends on AS_HAS_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select X86_INTEL_CET
+	select ARCH_HAS_SHADOW_STACK
+	help
+	  Shadow Stacks provides protection against program stack
+	  corruption.  It's a hardware feature.  This only matters
+	  if you have the right hardware.  It's a security hardening
+	  feature and apps must be enabled to use it.  You get no
+	  protection "for free" on old userspace.  The hardware can
+	  support user and kernel, but this option is for user space
+	  only.
+
+	  If unsure, say y.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/scripts/as-x86_64-has-shadow-stack.sh b/scripts/as-x86_64-ha=
s-shadow-stack.sh
new file mode 100755
index 000000000000..fac1d363a1b8
--- /dev/null
+++ b/scripts/as-x86_64-has-shadow-stack.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+echo "wrussq %rax, (%rbx)" | $* -x assembler -c -
--=20
2.21.0
