Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36067 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfBLPZq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Feb 2019 10:25:46 -0500
Date: Tue, 12 Feb 2019 16:25:45 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190212152543.GA24061@lst.de>
References: <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de> <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de> <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de> <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de> <20190208091818.GA23491@lst.de> <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de> <20190211073804.GA15841@lst.de> <820bfeb1-30c0-3d5a-54a2-c4f9a8c15b0e@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820bfeb1-30c0-3d5a-54a2-c4f9a8c15b0e@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190212152545.0j3jyIbLhcA37okF-IamokRT2z5kvVzYzv0RHPskLx4@z>

On Tue, Feb 12, 2019 at 01:42:56PM +0100, Christian Zigotzky wrote:
> On 11 February 2019 at 08:38AM, Christoph Hellwig wrote:
>> On Sun, Feb 10, 2019 at 01:00:20PM +0100, Christian Zigotzky wrote:
>>> I tested the whole series today. The kernels boot and the P.A. Semi
>>> Ethernet works! :-) Thanks a lot!
>>>
>>> I also tested it in a virtual e5500 QEMU machine today. Unfortunately the
>>> kernel crashes.
>> This looks like a patch I fixed in mainline a while ago, but which
>> the powerpc tree didn't have yet.
>>
>> I've cherry picked this commit
>> ("swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit")
>>
>> and added it to the powerpc-dma.6 tree, please retry with that one.
>>
> Hello Christoph,
>
> Have you added it to the powerpc-dma.6 tree yet? The last commit was 4 days 
> ago.

I added it, but forgot to push it out.  It is there now, sorry:

http://git.infradead.org/users/hch/misc.git/commitdiff/2cf0745b7420af4a3e871d5a970a45662dfae69c
