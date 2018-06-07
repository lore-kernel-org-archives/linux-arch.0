Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:61234 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933255AbeFGOma (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 10:42:30 -0400
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 1/7] x86/cet: Add Kconfig option for user-mode Indirect Branch Tracking
Date: Thu,  7 Jun 2018 07:38:49 -0700
Message-ID: <20180607143855.3681-2-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143855.3681-1-yu-cheng.yu@intel.com>
References: <20180607143855.3681-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20180607143849.zLXIzHQpZ3QHlj3XuPNU8W0_R5YaJLqeYOJMZxeP8lI@z>

The user-mode indirect branch tracking support is done mostly by
GCC to insert ENDBR64/ENDBR32 instructions at branch targets.
The kernel provides CPUID enumeration, feature MSR setup and
the allocation of legacy bitmap.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 24339a5299da..27bfbd137fbe 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1953,6 +1953,18 @@ config X86_INTEL_SHADOW_STACK_USER
 
 	  If unsure, say y.
 
+config X86_INTEL_BRANCH_TRACKING_USER
+	prompt "Intel Indirect Branch Tracking for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	select X86_INTEL_CET
+	select ARCH_HAS_PROGRAM_PROPERTIES
+	---help---
+	  Indirect Branch Tracking provides hardware protection against return-/jmp-
+	  oriented programing attacks.
+
+	  If unsure, say y
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
-- 
2.15.1
