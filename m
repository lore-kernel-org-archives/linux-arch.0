From: Christoph Hellwig <hch@lst.de>
Subject: DMA related cleanups for IA64
Date: Wed,  1 Aug 2018 18:02:43 +0200
Message-ID: <20180801160252.25629-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Hi all,

this is a resend of the last two series plus additional cleanups.  The
driver of it were the odd dma barriers in the ia64 sync_single_* methods,
but once I started to look into that area the fallback got bigger and
bigger..
