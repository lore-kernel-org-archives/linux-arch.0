Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbdALL14 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Jan 2017 06:27:56 -0500
From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 10/10] Revert "arm64/sve: Limit vector length to 512 bits by default"
Date: Thu, 12 Jan 2017 11:26:09 +0000
Message-ID: <1484220369-23970-11-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>
Message-ID: <20170112112609.dvCe5-3_DEbOCKwrAakq0-RowdIl1bv_-mFhnMIB08E@z>

This reverts commit cdedb254ccddd9c6a8db91b3737690327e48dfe7.

Vector length limiting via Kconfig is no longer required now that
the default vector length can be manipulated at runtime via procfs.
---
 arch/arm64/Kconfig   | 35 -----------------------------------
 arch/arm64/mm/proc.S |  5 -----
 2 files changed, 40 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 98c0934..bced568 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -900,41 +900,6 @@ config ARM64_SVE
 
 	  To enable use of this extension on CPUs that implement it, say Y.
 
-if ARM64_SVE
-
-config ARM64_SVE_FULL_VECTOR_LENGTH
-	bool "Enable full hardware vector length for userspace"
-	default n
-	help
-	  SVE vector lengths greater than 512 bits impact the size of signal
-	  frames and therefore the size requirements for any userspace stack
-	  onto which a signal may be delivered.  Using larger vector lengths
-	  may therefore cause problems for some software.  For this reason, the
-	  kernel currently limits the maximum vector length for userspace
-	  software to 512 bits by default.
-
-	  Enabling this option removes the limit, so that the full vector
-	  length implemented by the hardware is made available to userspace.
-
-	  Be aware: in general, software that (a) does not use SVE (including
-	  via libraries), or (b) does not handle signals, or (c) uses default
-	  process/thread stack sizes and does not use sigaltstack(2) should be
-	  unaffected by enabling larger vectors.  Software that does not meet
-	  these criteria or that relies on certain legacy uses of the ucontext
-	  API may be affected however.
-
-	  This is a transitional compatibility option only and will be replaced
-	  by a userspace ABI extension in the future.  Do not assume that this
-	  option will be available with compatible effect in future Linux
-	  releases.
-
-	  If you are developing software that uses SVE and understand the
-	  implications, you can consider saying Y here.
-
-	  If unsure, say N.
-
-endif
-
 config ARM64_MODULE_CMODEL_LARGE
 	bool
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index da2d602..aa96b4c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -200,11 +200,6 @@ ENTRY(__cpu_setup)
 
 	mrs_s	x5, ZIDR_EL1			// SVE: Enable full vector len
 	and	x5, x5, #ZCR_EL1_LEN_MASK	// initially
-#ifndef CONFIG_ARM64_SVE_FULL_VECTOR_LENGTH
-	mov	x6, #(512 / 128 - 1)		// Clamp VL to 512 bits
-	cmp	x5, x6
-	csel	x5, x5, x6, lo
-#endif
 	msr_s	ZCR_EL1, x5
 
 	b	2f
-- 
2.1.4

