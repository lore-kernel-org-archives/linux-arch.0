From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 10/10] Revert "arm64/sve: Limit vector length to 512 bits
 by default"
Date: Thu, 12 Jan 2017 11:26:09 +0000
Message-ID: <1484220369-23970-11-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Joseph Myers <joseph@codesourcery.com>, Alan Hayward <alan.hayward@arm.com>, Torvald Riegel <triegel@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: linux-arch.vger.kernel.org

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
