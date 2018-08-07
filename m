Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:32873 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbeHGQDC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Aug 2018 12:03:02 -0400
Date: Tue, 7 Aug 2018 15:53:57 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: DMA related cleanups for IA64
Message-ID: <20180807135357.GA31034@lst.de>
References: <20180801160252.25629-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801160252.25629-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Message-ID: <20180807135357.GCtuvtHtXzjrrGnMZcyKOvWEW16VfKU-tKM-H-FFj3M@z>

Yonu, Fenghua,

any chance you could look over these patches for 4.19?  That would
make my life for the next merge window a lot easier.

On Wed, Aug 01, 2018 at 06:02:43PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this is a resend of the last two series plus additional cleanups.  The
> driver of it were the odd dma barriers in the ia64 sync_single_* methods,
> but once I started to look into that area the fallback got bigger and
> bigger..
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
