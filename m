From: Christoph Hellwig <hch@lst.de>
Subject: barriers vs I/O and DMA for ia64
Date: Tue, 31 Jul 2018 19:20:30 +0200
Message-ID: <20180731172031.4447-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Hi all,

please review these patches carefully - ia64 currenly seems to be
the odd one out in terms of barrier placement for DMA and I/O and
this patch tries to resolve it.  But I don't have any IA64 hardware
nor do I know the architecture to well, so don't blindly trust me.
