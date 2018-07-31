Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbeGaTBz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jul 2018 15:01:55 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: barriers vs I/O and DMA for ia64
Date: Tue, 31 Jul 2018 19:20:30 +0200
Message-ID: <20180731172031.4447-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Message-ID: <20180731172030.V1n1AfqRZgR40Crl43TpOh-f46IGk5DLWlQM9X6gMsU@z>

Hi all,

please review these patches carefully - ia64 currenly seems to be
the odd one out in terms of barrier placement for DMA and I/O and
this patch tries to resolve it.  But I don't have any IA64 hardware
nor do I know the architecture to well, so don't blindly trust me.
