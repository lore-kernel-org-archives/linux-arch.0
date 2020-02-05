Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43402 "EHLO mga09.intel.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1727279AbgBESX1
 (ORCPT <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 13:23:27 -0500
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 1/7] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
Date: Wed,  5 Feb 2020 10:23:02 -0800
Message-ID: <20200205182308.4028-2-yu-cheng.yu@intel.com>
In-Reply-To: <20200205182308.4028-1-yu-cheng.yu@intel.com>
References: <20200205182308.4028-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20200205182302.L9Ji9nPHkmYDLUjvPj3VClc0rhSyklXE9P-CbLhjeCs@z>

Introduce Kconfig option X86_INTEL_BRANCH_TRACKING_USER.

Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
oriented programming attacks.  It is active when the kernel has this
feature enabled, and the processor and the application support it.
When this feature is enabled, legacy non-IBT applications continue to
work, but without IBT protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig  | 15 +++++++++++++++
 arch/x86/Makefile |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d1447380e02e..563f3c81f323 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1998,6 +1998,21 @@ config X86_INTEL_SHADOW_STACK_USER

 	  If unsure, say y.

+config X86_INTEL_BRANCH_TRACKING_USER
+	prompt "Intel Indirect Branch Tracking for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	select X86_INTEL_CET
+	---help---
+	  Indirect Branch Tracking (IBT) provides protection against
+	  CALL-/JMP-oriented programming attacks.  It is active when
+	  the kernel has this feature enabled, and the processor and
+	  the application support it.  When this feature is enabled,
+	  legacy non-IBT applications continue to work, but without
+	  IBT protection.
+
+	  If unsure, say y
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index c34f5befa4c8..f97b2c1c4d04 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -156,6 +156,13 @@ ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
   endif
 endif

+# Check compiler ibt support
+ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+  ifeq ($(call cc-option-yn, -fcf-protection=branch), n)
+      $(error CONFIG_X86_INTEL_BRANCH_TRACKING_USER not supported by compiler)
+  endif
+endif
+
 #
 # If the function graph tracer is used with mcount instead of fentry,
 # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
-- 
2.21.0
