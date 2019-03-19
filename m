Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfCSPQH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Mar 2019 11:16:07 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 0/5] arm64: compat: Reduce address limit
Date: Tue, 19 Mar 2019 15:15:37 +0000
Message-ID: <20190319151542.19557-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190319151537.ZErQxVf8z-ulJaDpL5k7WctXWIaSZMhyC0TC6LR2vM4@z>

This patchset reduces the size of the user-accessible address space
for compat tasks by a page.

Currently, compat tasks running on arm64 can allocate memory up to
TASK_SIZE_32 (UL(0x100000000)).

This means that mmap() allocations, if we treat them as returning an
array, are not compliant with the sections 6.5.8 of the C standard
(C99) which states that: "If the expression P points to an element of
an array object and the expression Q points to the last element of the
same array object, the pointer expression Q+1 compares greater than P".

A solution to this problem is to reduce TASK_SIZE_32 of a page.

But, in the current implementation, compat installs a special page
called "[vectors]" that contains sigreturn trampolines and kuser
helpers, and this is done at fixed address specified by the kuser
helpers ABI (0xffff0000) which overlaps with the last page when 64K
pages are enabled.

This patchset address the issue creating separate pages for vectors
and sigpage in a similar way to what happens today on arm and
disabling kuser helpers when 64K pages are enabled.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jann Horn <jannh@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (5):
  arm64: compat: Alloc separate pages for vectors and sigpage
  arm64: compat: Split kuser32
  arm64: compat: Refactor aarch32_alloc_vdso_pages()
  arm64: compat: Add KUSER_HELPERS config option
  arm64: compat: Reduce address limit

 arch/arm64/Kconfig                 |  31 ++++++
 arch/arm64/include/asm/elf.h       |   6 +-
 arch/arm64/include/asm/processor.h |   6 +-
 arch/arm64/include/asm/signal32.h  |   2 -
 arch/arm64/kernel/Makefile         |   5 +-
 arch/arm64/kernel/kuser32.S        |  65 +------------
 arch/arm64/kernel/signal32.c       |   5 +-
 arch/arm64/kernel/sigreturn32.S    |  46 +++++++++
 arch/arm64/kernel/vdso.c           | 150 +++++++++++++++++++++++------
 9 files changed, 213 insertions(+), 103 deletions(-)
 create mode 100644 arch/arm64/kernel/sigreturn32.S

-- 
2.21.0
