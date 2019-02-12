Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:18326 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfBLTcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 14:32:04 -0500
Subject: Re: use generic DMA mapping code in powerpc V4
References: <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
 <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
 <20190208091818.GA23491@lst.de>
 <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
 <20190211073804.GA15841@lst.de>
 <820bfeb1-30c0-3d5a-54a2-c4f9a8c15b0e@xenosoft.de>
 <20190212152543.GA24061@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <47bff9d1-7001-4d92-4ad1-e24215b56555@xenosoft.de>
Date: Tue, 12 Feb 2019 20:31:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190212152543.GA24061@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190212193156.aMBdeehKQ4LSWDdYpSsbbwsMy_UF1lMmALeiUxHeF5U@z>

On 12 February 2019 at 4:25PM, Christoph Hellwig wrote:
> On Tue, Feb 12, 2019 at 01:42:56PM +0100, Christian Zigotzky wrote:
>> On 11 February 2019 at 08:38AM, Christoph Hellwig wrote:
>>> On Sun, Feb 10, 2019 at 01:00:20PM +0100, Christian Zigotzky wrote:
>>>> I tested the whole series today. The kernels boot and the P.A. Semi
>>>> Ethernet works! :-) Thanks a lot!
>>>>
>>>> I also tested it in a virtual e5500 QEMU machine today. Unfortunately the
>>>> kernel crashes.
>>> This looks like a patch I fixed in mainline a while ago, but which
>>> the powerpc tree didn't have yet.
>>>
>>> I've cherry picked this commit
>>> ("swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit")
>>>
>>> and added it to the powerpc-dma.6 tree, please retry with that one.
>>>
>> Hello Christoph,
>>
>> Have you added it to the powerpc-dma.6 tree yet? The last commit was 4 days
>> ago.
> I added it, but forgot to push it out.  It is there now, sorry:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/2cf0745b7420af4a3e871d5a970a45662dfae69c
>
Hi Christoph

Many thanks! Your Git kernel works in a virtual e5500 machine now! :-)

I think we have reached the end of testing! All things are working with 
your DMA updates.

I am looking forward to test your DMA changes in the next merge window 
again. :-)

Cheers
Christian
