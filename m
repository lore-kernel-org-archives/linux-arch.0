From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v4 25/26] arm64: mte: Kconfig entry
Date: Fri, 15 May 2020 18:16:11 +0100
Message-ID: <20200515171612.1020-26-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:59632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgEORRM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:17:12 -0400
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add Memory Tagging Extension support to the arm64 kbuild.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v4:
    - select ARCH_USES_PG_ARCH_2
    - remove ARCH_NO_SWAP
    - default y

 arch/arm64/Kconfig | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..70deb14d78e0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1606,6 +1606,39 @@ config ARCH_RANDOM
 
 endmenu
 
+menu "ARMv8.5 architectural features"
+
+config ARM64_AS_HAS_MTE
+	def_bool $(as-instr,.arch armv8.5-a+memtag)
+
+config ARM64_MTE
+	bool "Memory Tagging Extension support"
+	default y
+	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_USES_PG_ARCH_2
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
+endmenu
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
