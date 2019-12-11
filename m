Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:43098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKSkv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:51 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 08/22] arm64: mte: Assembler macros and default architecture for .S files
Date: Wed, 11 Dec 2019 18:40:13 +0000
Message-ID: <20191211184027.20130-9-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20191211184013.bEUX-XYRBD2SCNYDSP0VNo-wMnWctlu8OWswUhNHK60@z>

Add the multitag_transfer_size macro to the arm64 assembler.h, together
with '.arch armv8.5-a+memtag' when CONFIG_ARM64_MTE is enabled.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/assembler.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index b8cf7c85ffa2..74a649a0b6e6 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -21,8 +21,13 @@
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_ARM64_MTE
+	.arch armv8.5-a+memtag
+#endif
+
 	.macro save_and_disable_daif, flags
 	mrs	\flags, daif
 	msr	daifset, #0xf
@@ -756,4 +761,15 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
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
