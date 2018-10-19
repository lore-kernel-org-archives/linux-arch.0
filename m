Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSUPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Oct 2018 16:15:51 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v3
Date: Fri, 19 Oct 2018 14:09:43 +0200
Message-ID: <20181019120952.32763-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181019120943.8bpHwABXvvhpUMRVjK15aPSbTlrcnA0jqTPdNARaapQ@z>

Hi all,

currently every architecture that wants to provide on of the common
periphal busses needs to add some boilerplate code and include the
right Kconfig files.   This series instead just selects the presence
(when needed) and then handles everything in the bus-specific
Kconfig file under drivers/.

Changes since v2:
 - depend on HAVE_PCI for PCIe endpoint code
 - fix some commit message typos
 - remove CONFIG_PCI from xtensa iss defconfig
 - drop EISA support from arm
 - clean up EISA selection for alpha

Changes since v1:
 - rename all HAS_* Kconfig symbols to HAVE_*
 - drop the CONFIG_PCI_QSPAN option entirely
 - drop duplicate select from powerpc
 - restore missing selection of PCI_MSI for riscv
 - update x86 and riscv defconfigs to include PCI
 - actually inclue drivers/eisa/Kconfig
 - adjust some captilizations
