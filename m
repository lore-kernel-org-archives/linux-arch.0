Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeGaNTh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jul 2018 09:19:37 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: include architecture Kconfig files from top-level Kconfig v4
Date: Tue, 31 Jul 2018 13:39:25 +0200
Message-ID: <20180731113935.6105-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180731113925.AaEbByXs3PV1v_pfEuCk6zOmJAChmMPxE0_TRM6k6l8@z>

Hi Masahiro,

what do you think about the series below, which moves the includes
of all the architecture independ Kconfig files to the top-level
Kconfig instead of duplicating the includes in all architectures?

Note that this only handles the low-hanging fruite, there are a lot
of other bits that should probably be cleaned up to be common,
but those will be not entirely trivial.

Changes since v3:
 - don't allow to select PREEMPT_COUNT for architectures that don't
   implement it
 - fix usage of SUBARCH=i386 and SUBARCH=x86_64 for um

Changes since v2:
 - fix the missing sh conversion
 - handle the lack of CONFIG_SWAP support in microblaze and nios2
   properly

Changes since v1:
 - add back a remove source statement from arch/arm/Kconfig
 - various fixes from Randy
 - various UML patches to be able to use the common Kconfig
