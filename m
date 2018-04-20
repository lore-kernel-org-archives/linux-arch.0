Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35856 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeDTHe1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2018 03:34:27 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling for powerpc
Date: Fri, 20 Apr 2018 17:34:10 +1000
Message-ID: <20180420073414.23169-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>, Nicolas Pitre <nico@fluxnic.net>
Message-ID: <20180420073410.pRBDKIDOAf8G1oy3hkCUR6_MpsE2VagEk8JXQ0W4DzE@z>

A few people have been interested in this again. And I promised
if it remains dead code it should be removed, so I would like to
have another try.

I think I got snagged on the modules problem last time and did
not take the time to work it out, this time I just turned off the
compile options for modules (the linker option was never set anyway
so no loss).

This includes some linker script catches and ideas from others, I
didn't documnt them all, but thanks for looking.

I would be interested to help other archs get this working too, if
anybody needs some help.

Thanks,
Nick

Nicholas Piggin (4):
  kbuild: Fix asm-generic/vmlinux.lds.h for
    LD_DEAD_CODE_DATA_ELIMINATION
  kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
    -ffunction-sections/-fdata-sections for module build
  kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if
    enabled
  powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected

 Makefile                          |  4 +--
 arch/Kconfig                      | 15 ----------
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++-------
 include/asm-generic/vmlinux.lds.h | 49 ++++++++++++++++++-------------
 init/Kconfig                      | 27 +++++++++++++++++
 6 files changed, 70 insertions(+), 48 deletions(-)

-- 
2.17.0
