Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34395 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbeESGeJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 May 2018 02:34:09 -0400
Date: Sat, 19 May 2018 08:38:57 +0200
From: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
        implementation
Message-ID: <20180519063857.GA18076@lst.de>
References: <20180511075945.16548-1-hch@lst.de> <20180511075945.16548-3-hch@lst.de> <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com> <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "hch@lst.de" <hch@lst.de>, "deanbo422@gmail.com" <deanbo422@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>
Message-ID: <20180519063857.wyfr4tRuYKiE_J_p2XGrHaNCcm6XC30vPbZ3hINW8JI@z>

On Fri, May 18, 2018 at 10:05:51PM +0200, Helge Deller wrote:
> This patch seems to fix the dma issues I faced on my 32bit B160L parisc box.
> 
> So it leaves only one open issue on parisc:
> Now every 32 bit parisc system is unnecessarily non-coherent.

I diagree with those comments, let me resend the refactored patch
to make it more clear.
