Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:46417 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGCBYc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jul 2018 21:24:32 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] arm,arm64,microblaze: add endianness options to LDFLAGS instead of LD
Date: Tue,  3 Jul 2018 10:21:58 +0900
Message-ID: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Message-ID: <20180703012158.cCpZj9fQQIxKO52JtkGjMdacyFYYCzPZ4HR7fKYJUIo@z>


We are able to evaluate compiler / toolchain capability in the
Kconfig phase.
(If you do not know the background of this work, please read
 the commit log of 316d55d55f49eca442e4fd948f5fa92bab0c8312)

To achieve this, 'CC', 'LD', etc. must be passed to Kconfig.

arch/*/Makefile should not tweak such environment variables
depending on CONFIG options - this would cause circular dependency.
  - We want to pass $(LD) from Makefile to Kconfig
  - CONFIG_CPU_BIG_ENDIAN is defined by Kconfig, then given
    back to Makefile

Nicholas already fixed this issue for PowerPC in commit 1421dc6d48296a.

I need to fix arm, arm64, microblaze as well
before I start moving linker option tests to Kconfig from Makefile.

arch maintainers:
Please pick up a proper patch for your tree.



Masahiro Yamada (3):
  ARM: add endianness option to LDFLAGS instead of LD
  arm64: add endianness option to LDFLAGS instead of LD
  microblaze: add endianness options to LDFLAGS instead of LD

 arch/arm/Makefile        | 4 ++--
 arch/arm64/Makefile      | 6 ++----
 arch/microblaze/Makefile | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.7.4
