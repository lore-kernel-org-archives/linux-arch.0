Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55065 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKHiG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Feb 2019 02:38:06 -0500
Date: Mon, 11 Feb 2019 08:38:04 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190211073804.GA15841@lst.de>
References: <20190204075616.GA5408@lst.de> <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de> <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de> <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de> <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de> <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de> <20190208091818.GA23491@lst.de> <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190211073804.HU8_IKwZsOgvUR_STLKhR2j3p26BAmx77HMrEKBHQWg@z>

On Sun, Feb 10, 2019 at 01:00:20PM +0100, Christian Zigotzky wrote:
> I tested the whole series today. The kernels boot and the P.A. Semi 
> Ethernet works! :-) Thanks a lot!
>
> I also tested it in a virtual e5500 QEMU machine today. Unfortunately the 
> kernel crashes.

This looks like a patch I fixed in mainline a while ago, but which
the powerpc tree didn't have yet.

I've cherry picked this commit
("swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit")

and added it to the powerpc-dma.6 tree, please retry with that one.
