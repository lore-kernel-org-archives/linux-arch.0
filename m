Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48127 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbeEVLsG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 May 2018 07:48:06 -0400
Date: Tue, 22 May 2018 13:53:20 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/20] arm-nommu: use generic dma_noncoherent_ops
Message-ID: <20180522115320.GA14530@lst.de>
References: <20180511075945.16548-1-hch@lst.de> <20180511075945.16548-5-hch@lst.de> <20180511091114.GA16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511091114.GA16141@n2100.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180522115320._Ttp92tMIi7j6StjwxrOqGPjY70mhvf6lmg5VekZ3fw@z>

On Fri, May 11, 2018 at 10:11:15AM +0100, Russell King - ARM Linux wrote:
> > +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> > +		size_t size, enum dma_data_direction dir)
> 
> Please no.  There is a lot of history of these (__dma_page_cpu_to_dev etc)
> functions being abused by out of tree drivers, because they think they
> know better.  This is stopped by making them static and ensuring that
> drivers have no access to these functions.
> 
> Please do not re-expose these to the global kernel.
> 
> While it may make things easier for a cross-architecture point of view,
> it makes it a lot easier for people to abuse these private APIs.

The point of this series, which isn't fully archived yet, is to
consolidate the direct mapping dma code, that is all dma_map_ops
instances except for iommus.  It is in fact in many ways modelled
after the ARM code.  For that we need the architectures to supply
the cache maintainance routines.

However, even if they now appear in dma-noncoherent.h they are NOT
and will NOT be exported, so using them directly from drivers won't
easily be possible.

I'll drop the arm-nommu patch for now, but I will pester your with this
again once arm is the last architecture not sharing the common code.

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
---end quoted text---
