From: Arnd Bergmann <arnd@arndb.de>
Subject: asm-generic changes for 4.6
Date: Thu, 24 Mar 2016 22:12:07 +0100
Message-ID: <11845534.Q9psV3m4LA@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56652 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcCXVMN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Mar 2016 17:12:13 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-4.6

for you to fetch changes up to a1cbaad75a8f891bca9cc65a1fb95ae1b28d2f6a:

  asm-generic: remove old nonatomic-io wrapper files (2016-03-01 22:25:17 +0100)

----------------------------------------------------------------
asm-generic changes for 4.6

There are only three patches this time, most other changes to
files in include/asm-generic tend to go through the tree of whoever
depends on the change.

Two patches are cleanups for stuff that is no longer needed,
the main change is to adapt the generic version of BUG_ON()
for CONFIG_BUG=n to make it behave consistently with BUG().

This avoids undefined behavior along with a number of warnings
about that undefined behavior in randconfig builds when
we keep going on after hitting a BUG_ON().

----------------------------------------------------------------
Arnd Bergmann (2):
      asm-generic: default BUG_ON(x) to if(x)BUG()
      asm-generic: remove old nonatomic-io wrapper files

Chen Gang (1):
      asm-generic: page.h: Remove useless get_user_page and free_user_page

 arch/arc/include/asm/page.h                         | 3 ---
 arch/arm/include/asm/page-nommu.h                   | 3 ---
 arch/frv/include/asm/page.h                         | 3 ---
 arch/m68k/include/asm/page_mm.h                     | 3 ---
 arch/m68k/include/asm/page_no.h                     | 3 ---
 arch/openrisc/include/asm/page.h                    | 3 ---
 drivers/dma/idma64.h                                | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h        | 2 +-
 include/asm-generic/bug.h                           | 2 +-
 include/asm-generic/io-64-nonatomic-hi-lo.h         | 2 --
 include/asm-generic/io-64-nonatomic-lo-hi.h         | 2 --
 include/asm-generic/page.h                          | 3 ---
 13 files changed, 4 insertions(+), 29 deletions(-)
 delete mode 100644 include/asm-generic/io-64-nonatomic-hi-lo.h
 delete mode 100644 include/asm-generic/io-64-nonatomic-lo-hi.h
