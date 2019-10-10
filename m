Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfJJSpm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 14:45:42 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v2 04/12] arm64: docs: cpu-feature-registers: Document ID_AA64PFR1_EL1
Date: Thu, 10 Oct 2019 19:44:32 +0100
Message-ID: <1570733080-21015-5-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <richard.henderson@linaro.org>, Sudakshina Das <sudi.das@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191010184432.DcU6EITVPSyM4dtggJnr3ttzVrgUzALFo1vot30tOcM@z>

Commit d71be2b6c0e1 ("arm64: cpufeature: Detect SSBS and advertise
to userspace") exposes ID_AA64PFR1_EL1 to userspace, but didn't
update the documentation to match.

Add it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Note to maintainers:

 * This patch has been racing with various other attempts to fix
   the same documentation in the meantime.

   Since this patch only fixes the documenting for pre-existing
   features, it can safely be dropped if appropriate.

   The _new_ documentation relating to BTI feature reporting
   is in a subsequent patch, and needs to be retained.
---
 Documentation/arm64/cpu-feature-registers.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index 2955287..b86828f 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -168,8 +168,15 @@ infrastructure:
      +------------------------------+---------+---------+
 
 
-  3) MIDR_EL1 - Main ID Register
+  3) ID_AA64PFR1_EL1 - Processor Feature Register 1
+     +------------------------------+---------+---------+
+     | Name                         |  bits   | visible |
+     +------------------------------+---------+---------+
+     | SSBS                         | [7-4]   |    y    |
+     +------------------------------+---------+---------+
+
 
+  4) MIDR_EL1 - Main ID Register
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
@@ -188,7 +195,7 @@ infrastructure:
    as available on the CPU where it is fetched and is not a system
    wide safe value.
 
-  4) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
+  5) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
 
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
@@ -210,7 +217,7 @@ infrastructure:
      | DPB                          | [3-0]   |    y    |
      +------------------------------+---------+---------+
 
-  5) ID_AA64MMFR2_EL1 - Memory model feature register 2
+  6) ID_AA64MMFR2_EL1 - Memory model feature register 2
 
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
@@ -218,7 +225,7 @@ infrastructure:
      | AT                           | [35-32] |    y    |
      +------------------------------+---------+---------+
 
-  6) ID_AA64ZFR0_EL1 - SVE feature ID register 0
+  7) ID_AA64ZFR0_EL1 - SVE feature ID register 0
 
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
-- 
2.1.4
