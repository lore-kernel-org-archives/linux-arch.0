Return-Path: <ink@jurassic.park.msu.ru>
Received: from jurassic.park.msu.ru ([195.208.223.243]:57360 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261178AbUCAKXp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Mar 2004 05:23:45 -0500
Date: Mon, 1 Mar 2004 13:23:27 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: dma_mask semantic problems
Message-ID: <20040301132327.A3356@jurassic.park.msu.ru>
References: <1078101455.10826.87.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078101455.10826.87.camel@gaston>; from benh@kernel.crashing.org on Mon, Mar 01, 2004 at 11:37:36AM +1100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 01, 2004 at 11:37:36AM +1100, Benjamin Herrenschmidt wrote:
> The current stuff is wrong in some cases, it happens to work
> because both archs and drivers are cheating... It gets even worse
> when DAC gets into the picture...

Precisely. :-(
Note that DAC DMA have additional restrictions on some platforms.
That is, to use DAC on Alpha, the PCI device must be able to generate
at least 40-bit addresses to access "monster window" on IOMMU.
On sparc64, IIRC, the DAC-capable device must have full 64-bit DMA.
But there are some devices, like older LSI chips, which are limited
to 39 or so bit DMA in DAC mode.
For PCI, we handle that with pci_dac_dma_supported(), which is
completely ignored by generic dma stuff...

Ivan.
