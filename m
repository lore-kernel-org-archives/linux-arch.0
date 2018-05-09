Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42346 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934689AbeEINAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 09:00:12 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling for powerpc
Date: Wed,  9 May 2018 22:59:57 +1000
Message-ID: <20180509130001.24276-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180509125957.HpHbohOBcSEx16o4_ylviS0RF4TY_SQqrAxtuecKKkE@z>

v2 changes only patch 4, updates the changelog with ppc32 numbers and
Tested-by tags, and also use TEXT_MAIN in the linker script as
Christophe suggested.

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
