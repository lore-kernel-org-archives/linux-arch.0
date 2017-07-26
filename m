Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41389 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbdGZXTX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jul 2017 19:19:23 -0400
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 26 Jul 2017 17:19:11 -0600
Message-ID: <20170726231917.6073-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [PATCH v5 0/6] make io{read|write}64 globally usable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>
Message-ID: <20170726231911.aKk2vnFbS9rHQivy-U39W5BKh7CQLehEghAzvrZhdEw@z>

Changes since v4:
- Add functions so the powerpc implementation of iomap.c compiles. (As
noticed by Horia)

Changes since v3:

- I noticed powerpc didn't use the appropriate functions seeing
readq/writeq were not defined when iomap.h was included. Thus I've
included a patch to adjust this
- Fixed some mistakes with a couple of the defines in io-64-nonatomic*
headers
- Fixed a typo noticed by Horia.

(earlier versions were drastically different)


Horia Geantă (1):
  crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64

Logan Gunthorpe (5):
  powerpc: io.h: move iomap.h include so that it can use readq/writeq
    defs
  powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}
  iomap: introduce io{read|write}64_{lo_hi|hi_lo}
  io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
  ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks

 arch/powerpc/include/asm/io.h         |   6 +-
 arch/powerpc/kernel/iomap.c           |  40 +++++++++++
 drivers/crypto/caam/regs.h            |  35 ++-------
 drivers/ntb/hw/intel/ntb_hw_intel.c   |  30 +-------
 include/asm-generic/iomap.h           |  26 +++++--
 include/linux/io-64-nonatomic-hi-lo.h |  60 ++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h |  60 ++++++++++++++++
 lib/iomap.c                           | 132 ++++++++++++++++++++++++++++++++++
 8 files changed, 322 insertions(+), 67 deletions(-)

--
2.11.0
