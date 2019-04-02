Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:25450 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDBJIg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:36 -0400
Message-ID: <cover.1554195798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/9] Improve boot command line handling
Date: Tue,  2 Apr 2019 09:08:34 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20190402090834.HnoMEZJrSEjYNFh7uWwtNDwpbLfDluE8WTD-gLJnOCk@z>

The purpose of this series is to improve and enhance the
handling of kernel boot arguments.

It is first focussed on powerpc but also extends the capability
for other arches.

This is based on suggestion from Daniel Walker <danielwa@cisco.com>

Christophe Leroy (9):
  powerpc: enable appending of CONFIG_CMDLINE to bootloader's cmdline.
  Add generic function to build command line.
  drivers: of: use cmdline building function
  powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
  powerpc: convert to generic builtin command line
  Add capability to prepend the command line
  powerpc: add capability to prepend default command line
  Gives arches opportunity to use generically defined boot cmdline
    manipulation
  powerpc: use generic CMDLINE manipulations

 arch/powerpc/Kconfig                   | 23 ++------------
 arch/powerpc/kernel/prom_init.c        | 38 ++++++++++-------------
 arch/powerpc/kernel/prom_init_check.sh |  2 +-
 drivers/of/fdt.c                       | 23 +++-----------
 include/linux/cmdline.h                | 37 ++++++++++++++++++++++
 init/Kconfig                           | 56 ++++++++++++++++++++++++++++++++++
 6 files changed, 117 insertions(+), 62 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.13.3
