Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbeHARtV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Aug 2018 13:49:21 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: DMA related cleanups for IA64
Date: Wed,  1 Aug 2018 18:02:43 +0200
Message-ID: <20180801160252.25629-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Message-ID: <20180801160243.K-LttGe27dJKlg4fkk8TyZQlVP2qeLNWQXEX83PLCiw@z>

Hi all,

this is a resend of the last two series plus additional cleanups.  The
driver of it were the odd dma barriers in the ia64 sync_single_* methods,
but once I started to look into that area the fallback got bigger and
bigger..
