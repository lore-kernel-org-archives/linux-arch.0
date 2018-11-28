From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Wed, 28 Nov 2018 22:05:19 +1100
Message-ID: <87zhttfonk.fsf@concordia.ellerman.id.au>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127074253.GB30186@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Any comments?  I'd like to at least get the ball moving on the easy
> bits.

Nothing specific yet.

I'm a bit worried it might break one of the many old obscure platforms
we have that aren't well tested.

There's not much we can do about that, but I'll just try and test it on
everything I can find.

Is the plan that you take these via the dma-mapping tree or that they go
via powerpc?

cheers

> On Wed, Nov 14, 2018 at 09:22:40AM +0100, Christoph Hellwig wrote:
>> Hi all,
>> 
>> this series switches the powerpc port to use the generic swiotlb and
>> noncoherent dma ops, and to use more generic code for the coherent
>> direct mapping, as well as removing a lot of dead code.
>> 
>> As this series is very large and depends on the dma-mapping tree I've
>> also published a git tree:
>> 
>>     git://git.infradead.org/users/hch/misc.git powerpc-dma.4
>> 
>> Gitweb:
>> 
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4
>> 
>> Changes since v3:
>>  - rebase on the powerpc fixes tree
>>  - add a new patch to actually make the baseline amigaone config
>>    configure without warnings
>>  - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
>>    always present
>>  - fix compile in mem.c for one configuration
>>  - drop the full npu removal for now, will be resent separately
>>  - a few git bisection fixes
>> 
>> The changes since v1 are to big to list and v2 was not posted in public.
>> 
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
