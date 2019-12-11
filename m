Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:43036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfLKSkn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:43 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 03/22] arm64: alternative: Allow alternative_insn to always issue the first instruction
Date: Wed, 11 Dec 2019 18:40:08 +0000
Message-ID: <20191211184027.20130-4-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20191211184008.geKjTCVyHEm3sm-uZo8uR-0ACjxm4QzhIMvFEFuIQcQ@z>

There are situations where we do not want to disable the whole block
based on a config option, only the alternative part while keeping the
first instruction. Improve the alternative_insn assembler macro to take
a 'first_insn' argument, default 0 to preserve the current behaviour.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/alternative.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index b9f8d787eea9..b4d3ffe16ca6 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -101,7 +101,11 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	.byte \alt_len
 .endm
 
-.macro alternative_insn insn1, insn2, cap, enable = 1
+/*
+ * Disable the whole block if enable == 0, unless first_insn == 1 in which
+ * case insn1 will always be issued but without an alternative insn2.
+ */
+.macro alternative_insn insn1, insn2, cap, enable = 1, first_insn = 0
 	.if \enable
 661:	\insn1
 662:	.pushsection .altinstructions, "a"
@@ -112,6 +116,8 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 664:	.popsection
 	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
+	.elseif \first_insn
+	\insn1
 	.endif
 .endm
 
