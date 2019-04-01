Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDALUg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 07:20:36 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 0/4] arm64: compat: Add kuser helpers config option
Date: Mon,  1 Apr 2019 12:20:21 +0100
Message-ID: <20190401112025.40807-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190401112021.GbnK09rhUiCcxf1JCvKVKT9YNeskRR3Gj-iGHOrguIE@z>

Currently on arm64 compat kuser helper are enabled by default.

To be on pair with arm32, this patchset makes it possible to disable
the kuser helpers by adding a CONFIG_KUSER_HELPERS option which is
enabled by default to avoid compatibility issues.

When the config option is disabled:
 - The kuser helpers-related code is not compiled with the kernel.
 - The kuser helpers mapping, for any compat process, at 0xffff0000
   is not done.
 - Any attempt to use a kuser helper from a compat process will result
   in a segfault.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (4):
  arm64: compat: Alloc separate pages for vectors and sigpage
  arm64: compat: Split kuser32
  arm64: compat: Refactor aarch32_alloc_vdso_pages()
  arm64: compat: Add KUSER_HELPERS config option

 arch/arm64/Kconfig                 |  30 ++++++
 arch/arm64/include/asm/elf.h       |   6 +-
 arch/arm64/include/asm/processor.h |   4 +-
 arch/arm64/include/asm/signal32.h  |   2 -
 arch/arm64/kernel/Makefile         |   5 +-
 arch/arm64/kernel/kuser32.S        |  65 +------------
 arch/arm64/kernel/signal32.c       |   5 +-
 arch/arm64/kernel/sigreturn32.S    |  46 +++++++++
 arch/arm64/kernel/vdso.c           | 150 +++++++++++++++++++++++------
 9 files changed, 211 insertions(+), 102 deletions(-)
 create mode 100644 arch/arm64/kernel/sigreturn32.S

-- 
2.21.0
