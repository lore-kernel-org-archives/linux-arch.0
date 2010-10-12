From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 0/4] remove dma64_addr_t
Date: Tue, 12 Oct 2010 12:13:11 +0900
Message-ID: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:35331 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab0JLDWx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Oct 2010 23:22:53 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org

dma64_addr_t looks pointless (at least there is no point that an
architecture has the own dma64_addr_t typedef).

dma_addr_t is set to 32 or 64 bits appropriately. You can use u64
at places where you know that 64 bit address is always necessary.

=
 arch/alpha/include/asm/types.h     |   11 -----------
 arch/alpha/kernel/pci_iommu.c      |    4 ++--
 arch/arm/include/asm/types.h       |    6 ------
 arch/cris/include/asm/types.h      |    6 ------
 arch/m32r/include/asm/types.h      |    6 ------
 arch/m68k/include/asm/types.h      |    6 ------
 arch/mips/include/asm/pci/bridge.h |    2 +-
 arch/mips/include/asm/types.h      |    2 --
 arch/parisc/include/asm/types.h    |   13 -------------
 arch/powerpc/include/asm/types.h   |    2 --
 arch/s390/include/asm/types.h      |    2 --
 arch/sparc/include/asm/pci_64.h    |    2 +-
 arch/sparc/include/asm/types.h     |   18 ------------------
 arch/x86/include/asm/types.h       |    8 --------
 14 files changed, 4 insertions(+), 84 deletions(-)
