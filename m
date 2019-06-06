Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:42894 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfFFURj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:17:39 -0400
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 01/14] x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
Date: Thu,  6 Jun 2019 13:09:13 -0700
Message-ID: <20190606200926.4029-2-yu-cheng.yu@intel.com>
In-Reply-To: <20190606200926.4029-1-yu-cheng.yu@intel.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20190606200913.nUX4MOSzO_DODnA7B-SThKgh-8V9F8HJc3kaqgV_rVw@z>

The user-mode indirect branch tracking support is done mostly by GCC
to insert ENDBR64/ENDBR32 instructions at branch targets.  The kernel
provides CPUID enumeration and feature setup.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig  | 16 ++++++++++++++++
 arch/x86/Makefile |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index df8b57de75b2..47afe47c01eb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1921,6 +1921,9 @@ config X86_INTEL_CET
 config ARCH_HAS_SHSTK
 	def_bool n
 
+config ARCH_HAS_AS_LIMIT
+	def_bool n
+
 config X86_INTEL_SHADOW_STACK_USER
 	prompt "Intel Shadow Stack for user-mode"
 	def_bool n
@@ -1941,6 +1944,19 @@ config X86_INTEL_SHADOW_STACK_USER
 
 	  If unsure, say y.
 
+config X86_INTEL_BRANCH_TRACKING_USER
+	prompt "Intel Indirect Branch Tracking for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	select X86_INTEL_CET
+	select ARCH_HAS_AS_LIMIT
+	select ARCH_USE_GNU_PROPERTY
+	---help---
+	  Indirect Branch Tracking provides hardware protection against return-/jmp-
+	  oriented programming attacks.
+
+	  If unsure, say y
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 0b2e9df48907..25372cc4a303 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -155,6 +155,13 @@ ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
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
2.17.1
