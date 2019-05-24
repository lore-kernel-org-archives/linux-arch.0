Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389942AbfEXK03 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 06:26:29 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 3/8] arm64: docs: cpu-feature-registers: Document ID_AA64PFR1_EL1
Date: Fri, 24 May 2019 11:25:28 +0100
Message-ID: <1558693533-13465-4-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>, "H.J. Lu" <hjl.tools@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, Andrew Jones <drjones@redhat.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Sudakshina Das <sudi.das@arm.com>, Paul Elliott <paul.elliott@arm.com>
Message-ID: <20190524102528.TpMCpoRV9FMbOmMcFXGeQV-YFSnsl9iirwe2LxE-dDE@z>

Commit d71be2b6c0e1 ("arm64: cpufeature: Detect SSBS and advertise
to userspace") exposes ID_AA64PFR1_EL1 to userspace, but didn't
update the documentation to match.

Add it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 Documentation/arm64/cpu-feature-registers.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
index 684a0da..54d2bfa 100644
--- a/Documentation/arm64/cpu-feature-registers.txt
+++ b/Documentation/arm64/cpu-feature-registers.txt
@@ -160,7 +160,15 @@ infrastructure:
      x--------------------------------------------------x
 
 
-  3) MIDR_EL1 - Main ID Register
+  3) ID_AA64PFR1_EL1 - Processor Feature Register 1
+     x--------------------------------------------------x
+     | Name                         |  bits   | visible |
+     |--------------------------------------------------|
+     | SSBS                         | [7-4]   |    y    |
+     x--------------------------------------------------x
+
+
+  4) MIDR_EL1 - Main ID Register
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
      |--------------------------------------------------|
@@ -179,7 +187,7 @@ infrastructure:
    as available on the CPU where it is fetched and is not a system
    wide safe value.
 
-  4) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
+  5) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
 
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
@@ -201,7 +209,7 @@ infrastructure:
      | DPB                          | [3-0]   |    y    |
      x--------------------------------------------------x
 
-  5) ID_AA64MMFR2_EL1 - Memory model feature register 2
+  6) ID_AA64MMFR2_EL1 - Memory model feature register 2
 
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
@@ -209,7 +217,7 @@ infrastructure:
      | AT                           | [35-32] |    y    |
      x--------------------------------------------------x
 
-  6) ID_AA64ZFR0_EL1 - SVE feature ID register 0
+  7) ID_AA64ZFR0_EL1 - SVE feature ID register 0
 
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
-- 
2.1.4
