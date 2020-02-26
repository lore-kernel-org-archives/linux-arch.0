From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 05/19] arm64: mte: Assembler macros and default architecture for .S files
Date: Wed, 26 Feb 2020 18:05:12 +0000
Message-ID: <20200226180526.3272848-6-catalin.marinas@arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:40114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgBZSFo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:05:44 -0500
In-Reply-To: <20200226180526.3272848-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org

Add the multitag_transfer_size macro to the arm64 assembler.h, together
with '.arch armv8.5-a+memtag' when CONFIG_ARM64_MTE is enabled.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Notes:
    v2:
    - Separate .arch armv8.5-a from .arch_extension memtag.

 arch/arm64/include/asm/assembler.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index aca337d79d12..172d114ba8a8 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -21,8 +21,14 @@
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_ARM64_MTE
+	.arch		armv8.5-a
+	.arch_extension memtag
+#endif
+
 	.macro save_and_disable_daif, flags
 	mrs	\flags, daif
 	msr	daifset, #0xf
@@ -732,4 +738,15 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 .Lyield_out_\@ :
 	.endm
 
+/*
+ * multitag_transfer_size - set \reg to the block size that is accessed by the
+ * LDGM/STGM instructions.
+ */
+	.macro	multitag_transfer_size, reg, tmp
+	mrs_s	\reg, SYS_GMID_EL1
+	ubfx	\reg, \reg, #SYS_GMID_EL1_BS_SHIFT, #SYS_GMID_EL1_BS_SIZE
+	mov	\tmp, #4
+	lsl	\reg, \tmp, \reg
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
