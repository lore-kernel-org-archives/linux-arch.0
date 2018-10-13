Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:32912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJMWry (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2018 18:47:54 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/
Date: Sat, 13 Oct 2018 17:10:08 +0200
Message-ID: <20181013151016.31674-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181013151008.J7Pr3_gbTtmVaCXVCiLrQ4L7tIzJN9c1CPH_B1XuEMI@z>

Hi all,

currently every architecture that wants to provide on of the common
periphal busses needs to add some boilerplate code and include the
right Kconfig files.   This series instead just selects the presence
(when needed) and then handles everything in the bus-specific
Kconfig file under drivers/.
