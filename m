Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:36456 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbdGRQzf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jul 2017 12:55:35 -0400
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 18 Jul 2017 10:55:23 -0600
Message-ID: <20170718165528.7383-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [PATCH v4 0/5] make io{read|write}64 globally usable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>
Message-ID: <20170718165523.hzT7S190Hm4OuzNGg-9EauLQxThMTEnutRr-xiPmQ0M@z>

This is version four of my patchset to enable drivers to use
io{read|write}64 on all arches.

Changes since v3:

- I noticed powerpc didn't use the appropriate functions seeing
readq/writeq were not defined when iomap.h was included. Thus I've
included a patch to adjust this
- Fixed some mistakes with a couple of the defines in io-64-nonatomic*
headers
- Fixed a typo noticed by Horia.


Horia Geantă (1):
  crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64

Logan Gunthorpe (4):
  powerpc: io.h: move iomap.h include so that it can use readq/writeq
    defs
  iomap: introduce io{read|write}64_{lo_hi|hi_lo}
  io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
  ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks

 arch/powerpc/include/asm/io.h         |   6 +-
 drivers/crypto/caam/regs.h            |  35 ++-------
 drivers/ntb/hw/intel/ntb_hw_intel.c   |  30 +-------
 include/asm-generic/iomap.h           |  26 +++++--
 include/linux/io-64-nonatomic-hi-lo.h |  60 ++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h |  60 ++++++++++++++++
 lib/iomap.c                           | 132 ++++++++++++++++++++++++++++++++++
 7 files changed, 282 insertions(+), 67 deletions(-)

--
2.11.0
