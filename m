Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50225 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLAAUN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Nov 2018 19:20:13 -0500
Date: Fri, 30 Nov 2018 14:10:56 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181130131056.GA5211@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au> <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de> <20181129170351.GC27951@lst.de> <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de> <20181130105346.GB26765@lst.de> <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Message-ID: <20181130131056.E9HNz_JxpyNoE0xBsqNqc9D-vye55pCh9pAX4ngowU0@z>

On Fri, Nov 30, 2018 at 01:23:20PM +0100, Christian Zigotzky wrote:
> Hi Christoph,
>
> Thanks a lot for your fast reply.
>
> On 30 November 2018 at 11:53AM, Christoph Hellwig wrote:
>> Hi Christian,
>>
>> for such a diverse architecture like powerpc we'll have to rely on
>> users / non core developers like you to help with testing.
> I see. I will help as good as I can.
>>
>> Can you try the patch below for he cyrus config?
> Yes, of course. I patched your Git kernel and after that I compiled it 
> again. U-Boot loads the kernel and the dtb file. Then the kernel starts but 
> it doesn't find any hard disks (partitions).

Interesting.  Does it find the storage controller (what kind of
storage does it use?).

For the PASEMI board can you test the attached patch?  Also are you
using Compact Flash cards on that system?

> @All
> Could you please also test Christoph's kernel on your PASEMI and NXP 
> boards? Download: 'git clone git://git.infradead.org/users/hch/misc.git -b 
> powerpc-dma.4 a'

FYI, I've pushed a new powerpc-dma.5 with the various fixes discussed
in this thread.
