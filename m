Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:21097 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756807AbbIYRfn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Sep 2015 13:35:43 -0400
Subject: Re: [PATCH 4/4] dma-debug: Allow poisoning nonzero allocations
References: <cover.1443178314.git.robin.murphy@arm.com>
 <0405c6131def5aa179ff4ba5d4201ebde89cede3.1443178314.git.robin.murphy@arm.com>
 <20150925124447.GO21513@n2100.arm.linux.org.uk>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <560585EB.3060908@arm.com>
Date: Fri, 25 Sep 2015 18:35:39 +0100
MIME-Version: 1.0
In-Reply-To: <20150925124447.GO21513@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Message-ID: <20150925173539.aHWIC4VMSKuZt2mHRqqlKAoYZ6Hcuu3sR2zhgFw0jZo@z>

Hi Russell,

On 25/09/15 13:44, Russell King - ARM Linux wrote:
> On Fri, Sep 25, 2015 at 01:15:46PM +0100, Robin Murphy wrote:
>> Since some dma_alloc_coherent implementations return a zeroed buffer
>> regardless of whether __GFP_ZERO is passed, there exist drivers which
>> are implicitly dependent on this and pass otherwise uninitialised
>> buffers to hardware. This can lead to subtle and awkward-to-debug issues
>> using those drivers on different platforms, where nonzero uninitialised
>> junk may for instance occasionally look like a valid command which
>> causes the hardware to start misbehaving. To help with debugging such
>> issues, add the option to make uninitialised buffers much more obvious.
>
> The reason people started to do this is to stop a security leak in the
> ALSA code: ALSA allocates the ring buffer with dma_alloc_coherent()
> which used to grab pages and return them uninitialised.  These pages
> could contain anything - including the contents of /etc/shadow, or
> your bank details.
>
> ALSA then lets userspace mmap() that memory, which means any user process
> which has access to the sound devices can read data leaked from kernel
> memory.
>
> I think I did bring it up at the time I found it, and decided that the
> safest thing to do was to always return an initialised buffer - short of
> constantly auditing every dma_alloc_coherent() user which also mmap()s
> the buffer into userspace, I couldn't convince myself that it was safe
> to avoid initialising the buffer.
>
> I don't know whether the original problem still exists in ALSA or not,
> but I do know that there are dma_alloc_coherent() implementations out
> there which do not initialise prior to returning memory.

Indeed, I think we've discussed this before, and I don't imagine we'll 
be changing the actual behaviour of the existing allocators any time soon.

[ I still don't see that as an excuse for callers not to be fixed, 
though - anyone allocating something that may be exposed to userspace 
has a responsibility to initialise it appropriately. After all, the DMA 
API is just one source, what do we do if such a careless subsystem got 
some uninitialised pages of leftover sensitive data from, say, 
alloc_pages() instead? ]

That's a bit of a separate issue though. If a driver itself _needs_ a 
zeroed buffer but doesn't specifically request one, or doesn't get one 
even if it did, then that's just a regular bug, and it's what this patch 
is intended to help weed out. We've no need for a special poison value 
for data protection in the general case; zero is just fine for that.

>> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
>> index 908fb35..40514ed 100644
>> --- a/lib/dma-debug.c
>> +++ b/lib/dma-debug.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/sched.h>
>>   #include <linux/ctype.h>
>>   #include <linux/list.h>
>> +#include <linux/poison.h>
>>   #include <linux/slab.h>
>>
>>   #include <asm/sections.h>
>> @@ -1447,7 +1448,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
>>   EXPORT_SYMBOL(debug_dma_unmap_sg);
>>
>>   void debug_dma_alloc_coherent(struct device *dev, size_t size,
>> -			      dma_addr_t dma_addr, void *virt)
>> +			      dma_addr_t dma_addr, void *virt, gfp_t flags)
>>   {
>>   	struct dma_debug_entry *entry;
>>
>> @@ -1457,6 +1458,9 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
>>   	if (unlikely(virt == NULL))
>>   		return;
>>
>> +	if (IS_ENABLED(CONFIG_DMA_API_DEBUG_POISON) && !(flags & __GFP_ZERO))
>> +		memset(virt, DMA_ALLOC_POISON, size);
>> +
>
> This is likely to be slow in the case of non-cached memory and large
> allocations.  The config option should come with a warning.

It depends on DMA_API_DEBUG, which already has a stern performance 
warning, is additionally hidden behind EXPERT, and carries a slightly 
flippant yet largely truthful warning that actually using it could break 
pretty much every driver in your system; is that not enough?

If I was feeling particularly antagonistic, I'd also point out that as 
discussed above you've already taken the hit of a memset(0) and cache 
flush that you _didn't_ ask for, and there was no warning on that ;)

The intent is a specific troubleshooting tool - realistically it's 
probably only usable at all when restricting DMA debug to a per-driver 
basis. My hunch is that nobody's too fussed about the performance of a 
driver that doesn't work properly, especially once they've reached the 
point of dumping buffers in an attempt to figure out why, when seeing 
the presence or not of uniform poison values could be helpful.

(Of course, sometimes you end up debugging the allocator itself - see 
commit 7132813c3845 - which was one of the motivating factors for this 
patch).

Robin.

