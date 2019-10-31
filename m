Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43788 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJaAcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1so4331754wra.10
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:01 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 0/5] powerpc: make iowrite32be etc. inline
Date: Thu, 31 Oct 2019 01:31:49 +0100
Message-ID: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20191031003149.65wVDx39U4BbQDxYE_POhKpaTyvw4QdabDtxIr6V9yg@z>

When trying to make the QUICC Engine drivers compile on arm, I
mechanically (with coccinelle) changed out_be32() to iowrite32be()
etc. Christophe pointed out [1][2] that that would pessimize the
powerpc SOCs since the IO accesses now incur a function call
overhead. He asked that I try to make those io accessors inline on
ppc, and this is the best I could come up with.

At first I tried something that wouldn't need to touch anything
outside arch/powerpc/, but I ended up with conditional inclusion of
asm-generic headers and/or duplicating a lot of their contents.

The diffstat may become a little better if kernel/iomap.c can indeed
be removed (due to !CONFIG_PPC_INDIRECT_PIO &&
CONFIG_PPC_INDIRECT_MMIO never happening).

[1] https://lore.kernel.org/lkml/6ee121cf-0e3d-4aa0-2593-fcb00995e429@c-s.fr/
[2] https://lore.kernel.org/lkml/886d5218-6d6b-824c-3ab9-63aafe41ff40@c-s.fr/

Rasmus Villemoes (5):
  asm-generic: move pcu_iounmap from iomap.h to pci_iomap.h
  asm-generic: employ "ifndef foo; define foo foo" idiom in iomap.h
  powerpc: move pci_iounmap() from iomap.c to pci-common.c
  powerpc: make pcibios_vaddr_is_ioport() static
  powerpc: make iowrite32 and friends static inline when no indirection

 arch/powerpc/include/asm/io.h         | 172 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/pci-bridge.h |   9 --
 arch/powerpc/kernel/Makefile          |   2 +-
 arch/powerpc/kernel/iomap.c           |  13 --
 arch/powerpc/kernel/pci-common.c      |  15 ++-
 include/asm-generic/iomap.h           | 104 +++++++++++++---
 include/asm-generic/pci_iomap.h       |   7 ++
 7 files changed, 282 insertions(+), 40 deletions(-)

-- 
2.23.0
