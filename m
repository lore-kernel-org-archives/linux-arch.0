From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v7 28/29] arm64: mte: Kconfig entry
Date: Wed, 15 Jul 2020 18:08:43 +0100
Message-ID: <20200715170844.30064-29-catalin.marinas@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgGORJ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 13:09:56 -0400
In-Reply-To: <20200715170844.30064-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add Memory Tagging Extension support to the arm64 kbuild.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v7:
    - Binutils gained initial support for MTE in 2.32.0. However, a late
      architecture addition (LDGM/STGM) is only supported in the newer
      2.32.x and 2.33 versions. Change the AS_HAS_MTE option to also check
      for stgm in addition to .arch armv8.5-a+memtag.
    
    v6:
    - Remove select ARCH_USES_PG_ARCH_2, no longer defined.
    
    v5:
    - Remove duplicate ARMv8.5 menu entry.
    
    v4:
    - select ARCH_USES_PG_ARCH_2.
    - remove ARCH_NO_SWAP.
    - default y.

 arch/arm64/Kconfig | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..32ceff21acc1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1664,6 +1664,37 @@ config ARCH_RANDOM
 	  provides a high bandwidth, cryptographically secure
 	  hardware random number generator.
 
+config ARM64_AS_HAS_MTE
+	# Binutils gained initial support for MTE in 2.32.0. However, a
+	# late architecture addition (LDGM/STGM) is only supported in
+	# the newer 2.32.x and 2.33 versions.
+	def_bool $(as-instr,.arch armv8.5-a+memtag\nstgm xzr$(comma)[x0])
+
+config ARM64_MTE
+	bool "Memory Tagging Extension support"
+	default y
+	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
+	select ARCH_USES_HIGH_VMA_FLAGS
+	help
+	  Memory Tagging (part of the ARMv8.5 Extensions) provides
+	  architectural support for run-time, always-on detection of
+	  various classes of memory error to aid with software debugging
+	  to eliminate vulnerabilities arising from memory-unsafe
+	  languages.
+
+	  This option enables the support for the Memory Tagging
+	  Extension at EL0 (i.e. for userspace).
+
+	  Selecting this option allows the feature to be detected at
+	  runtime. Any secondary CPU not implementing this feature will
+	  not be allowed a late bring-up.
+
+	  Userspace binaries that want to use this feature must
+	  explicitly opt in. The mechanism for the userspace is
+	  described in:
+
+	  Documentation/arm64/memory-tagging-extension.rst.
+
 endmenu
 
 config ARM64_SVE
