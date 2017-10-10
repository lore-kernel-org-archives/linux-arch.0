Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932294AbdJJSjN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 14:39:13 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3 08/28] arm64/sve: Kconfig update and conditional compilation support
Date: Tue, 10 Oct 2017 19:38:25 +0100
Message-ID: <1507660725-7986-9-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171010183825.ZdnRg0NojDlHFJP1yeNI0syyIAIC8omozCa3cl1xyoo@z>

This patch adds CONFIG_ARM64_SVE to control building of SVE support
into the kernel, and adds a stub predicate system_supports_sve() to
control conditional compilation and runtime SVE support.

system_supports_sve() just returns false for now: it will be
replaced with a non-trivial implementation in a later patch, once
SVE support is complete enough to be enabled safely.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 arch/arm64/Kconfig                  | 11 +++++++++++
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ca711ac..9b3a50e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -975,6 +975,17 @@ config ARM64_PMEM
 
 endmenu
 
+config ARM64_SVE
+	bool "ARM Scalable Vector Extension support"
+	default y
+	help
+	  The Scalable Vector Extension (SVE) is an extension to the AArch64
+	  execution state which complements and extends the SIMD functionality
+	  of the base architecture to support much larger vectors and to enable
+	  additional vectorisation opportunities.
+
+	  To enable use of this extension on CPUs that implement it, say Y.
+
 config ARM64_MODULE_CMODEL_LARGE
 	bool
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 428ee1f..4ea3441 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -262,6 +262,11 @@ static inline bool system_uses_ttbr0_pan(void)
 		!cpus_have_const_cap(ARM64_HAS_PAN);
 }
 
+static inline bool system_supports_sve(void)
+{
+	return false;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
-- 
2.1.4
