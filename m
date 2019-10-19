Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34334 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfJSCUw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 22:20:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so4336817pgi.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2019 19:20:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/1] arm64: Implement archrandom.h for ARMv8.5-RNG
Date: Fri, 18 Oct 2019 19:20:47 -0700
Message-ID: <20191019022048.28065-1-richard.henderson@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com, linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Message-ID: <20191019022047.nR9ufEfvf8ZrOmFwJ2C12-VBcI6bB-XvB_klou8CZp0@z>

From: Richard Henderson <rth@twiddle.net>

The ARMv8.5-RNG extension adds a hardware random number generator.
The plumbing for this is already present in the kernel; we just
have to take advantage of that.

Possible issues:

When should we use RNDRRS?  For now I use it at boot, when validating
that the implementation can produce a random number, much like other
architectures validate before enabling.  I also use it if RNDR fails.
I don't know if that's a reasonable thing to do; the generic architecture
docs are too vague about what's going on behind the scenes.

I mark ARM64_HAS_RNG as ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE so that
it is detected early, because crng_initialize() is called early.
I don't know if this is quite the right thing if some hypothetial
big.LITTLE only has the RNG on the big cpus.

Tested with QEMU.


r~


Richard Henderson (1):
  arm64: Implement archrandom.h for ARMv8.5-RNG

 Documentation/arm64/cpu-feature-registers.rst |  2 +
 arch/arm64/include/asm/archrandom.h           | 76 +++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h              |  3 +-
 arch/arm64/include/asm/sysreg.h               |  1 +
 arch/arm64/kernel/cpufeature.c                | 34 +++++++++
 arch/arm64/Kconfig                            | 12 +++
 drivers/char/Kconfig                          |  4 +-
 7 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/archrandom.h

-- 
2.17.1
