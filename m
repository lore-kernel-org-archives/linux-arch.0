Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:33318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3Opm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 10:45:42 -0400
Date: Fri, 30 Aug 2019 15:45:36 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
Message-ID: <20190830144536.GJ36992@arrakis.emea.arm.com>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
 <20190820145821.27214-2-nsaenzjulienne@suse.de>
 <20190826070939.GD11331@lst.de>
 <027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, eric@anholt.net, linux-riscv@lists.infradead.org, frowand.list@gmail.com, m.szyprowski@samsung.com, linux-arch@vger.kernel.org, f.fainelli@gmail.com, will@kernel.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com, robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, phill@raspberryi.org, mbrugger@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, wahrenst@gmx.net, akpm@linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
Message-ID: <20190830144536.41dLfmOycuCYZxESLudezrcN8xP2aL7XZwG_nfQ-xUI@z>

On Mon, Aug 26, 2019 at 03:46:52PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2019-08-26 at 09:09 +0200, Christoph Hellwig wrote:
> > On Tue, Aug 20, 2019 at 04:58:09PM +0200, Nicolas Saenz Julienne wrote:
> > > Some architectures have platform specific DMA addressing limitations.
> > > This will allow for hardware description code to provide the constraints
> > > in a generic manner, so as for arch code to properly setup it's memory
> > > zones and DMA mask.
> > 
> > I know this just spreads the arm code, but I still kinda hate it.
> 
> Rob's main concern was finding a way to pass the constraint from HW definition
> to arch without widening fdt's architecture specific function surface. I'd say
> it's fair to argue that having a generic mechanism makes sense as it'll now
> traverse multiple archs and subsystems.
> 
> I get adding globals like this is not very appealing, yet I went with it as it
> was the easier to integrate with arm's code. Any alternative suggestions?

In some discussion with Robin, since it's just RPi4 that we are aware of
having such requirement on arm64, he suggested that we have a permanent
ZONE_DMA on arm64 with a default size of 1GB. It should cover all arm64
SoCs we know of without breaking the single Image binary. The arch/arm
can use its current mach-* support.

I may like this more than the proposed early_init_dt_get_dma_zone_size()
here which checks for specific SoCs (my preferred way was to build the
mask from all buses described in DT but I hadn't realised the
complications).

-- 
Catalin
