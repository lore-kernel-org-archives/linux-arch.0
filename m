Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33157 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfJ1Uc6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2019 16:32:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so497349wmf.0
        for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2019 13:32:57 -0700 (PDT)
From: richard.henderson@linaro.org
Subject: [PATCH v2 0/1] arm64: Implement archrandom.h for ARMv8.5-RNG
Date: Mon, 28 Oct 2019 21:32:53 +0100
Message-ID: <20191028203254.7152-1-richard.henderson@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com, Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20191028203253.9yGS1KhgWsuibaNk0kVOmzYcyIB-GY2SeZ3dKu2ezmg@z>

From: Richard Henderson <richard.henderson@linaro.org>

The ARMv8.5-RNG extension adds a hardware random number generator.
The plumbing for this is already present in the kernel; we just
have to take advantage of that.

Changes since v1:
  * Use __mrs_s and fix missing cc clobber (Mark),
  * Log rng failures with pr_warn (Mark),
  * Use __must_check; put RNDR in arch_get_random_long and RNDRRS
    in arch_get_random_seed_long (Ard),
  * Use ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE, and check this_cpu_has_cap
    when reading random data.
  * Move everything out of line, now that there are 5 other function
    calls involved, and to unify the rate limiting on the pr_warn.

I have a separate patch set to add __must_check to the other
architectures.  But it doesn't affect this.

Tested with QEMU.


r~


Richard Henderson (1):
  arm64: Implement archrandom.h for ARMv8.5-RNG

 Documentation/arm64/cpu-feature-registers.rst |  2 +
 arch/arm64/include/asm/archrandom.h           | 32 +++++++
 arch/arm64/include/asm/cpucaps.h              |  3 +-
 arch/arm64/include/asm/sysreg.h               |  4 +
 arch/arm64/kernel/cpufeature.c                | 13 +++
 arch/arm64/kernel/random.c                    | 95 +++++++++++++++++++
 arch/arm64/Kconfig                            | 12 +++
 arch/arm64/kernel/Makefile                    |  1 +
 drivers/char/Kconfig                          |  4 +-
 9 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/archrandom.h
 create mode 100644 arch/arm64/kernel/random.c

-- 
2.17.1
