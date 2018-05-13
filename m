Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:55933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751345AbeEMN0y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 13 May 2018 09:26:54 -0400
Subject: Re: common non-cache coherent direct dma mapping ops
References: <20180511075945.16548-1-hch@lst.de>
From: Helge Deller <deller@gmx.de>
Message-ID: <1834767f-0430-8f7f-61b1-560353cd6e5f@gmx.de>
Date: Sun, 13 May 2018 15:26:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180511075945.16548-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180513132620.6icBRO1hAblYx-oX2bproXgqnMyuRamZJyxKf2Fx7XY@z>

On 11.05.2018 09:59, Christoph Hellwig wrote:
> this series continues consolidating the dma-mapping code, with a focus
> on architectures that do not (always) provide cache coherence for DMA.
> Three architectures (arm, mips and powerpc) are still left to be
> converted later due to complexity of their dma ops selection.
> 
> The dma-noncoherent ops calls the dma-direct ops for the actual
> translation of streaming mappins and allow the architecture to provide
> any cache flushing required for cpu to device and/or device to cpu
> ownership transfers.  The dma coherent allocator is for now still left
> entirely to architecture supplied implementations due the amount of
> variations.  Hopefully we can do some consolidation for them later on
> as well.
> 
> A lot of architectures are currently doing very questionable things
> in their dma mapping routines, which are documented in the changelogs
> for each patch.  Please review them very careful and correct me on
> incorrect assumptions.
> 
> Because this series sits on top of two previously submitted series
> a git tree might be useful to actually test it.  It is provided here:
> 
>     git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent
> 
> Changes since RFC:
>  - fix a typo accidentally disabling the device to cpu transfer sync
>  - fixed a few compile failures


I tested it again on parisc (this time again on top of git head) and it still breaks
the same way as I reported in my mail on April 21st: the lasi82956 network driver works
unreliable. NIC gets IP, but ping doesn't work.
See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync() functions.

See comment in James mail from April 21st too:
-> you just made every 32 bit parisc system unnecessarily use non-coherent.

Helge
