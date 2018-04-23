Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39455 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeDWIJl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Apr 2018 04:09:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id z9so8619913pfe.6
        for <linux-arch@vger.kernel.org>; Mon, 23 Apr 2018 01:09:41 -0700 (PDT)
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
References: <20180420080313.18796-1-hch@lst.de>
 <20180420080313.18796-14-hch@lst.de>
 <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e78c09ad-ce68-a8ed-3cd9-2577c6e5539b@gmail.com>
Date: Mon, 23 Apr 2018 20:09:34 +1200
MIME-Version: 1.0
In-Reply-To: <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

Hi

Am 23.04.2018 um 18:49 schrieb Greentime Hu:
> 2018-04-20 16:03 GMT+08:00 Christoph Hellwig <hch@lst.de>:
>> Switch to the generic noncoherent direct mapping implementation.
>>
>> This makes sure kmap_atomic_pfn is consistently used for access to
>> virtual addresses instead of either using the slower plain kmap
>> or blindly expecting page_address() to work.
>>
>> This makes sure the cache_sync routines is called in the unmap_sg
>> case, to match the unmap_single and sync_{single,sg}_to_cpu cases.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
>   CC      arch/nds32/kernel/dma.o
> arch/nds32/kernel/dma.c: In function 'arch_sync_dma_for_device':
> arch/nds32/kernel/dma.c:333:10: error: 'direction' undeclared (first
> use in this function)
>   switch (direction) {
>           ^~~~~~~~~
> arch/nds32/kernel/dma.c:333:10: note: each undeclared identifier is
> reported only once for each function it appears in
> arch/nds32/kernel/dma.c: In function 'arch_sync_dma_for_cpu':
> arch/nds32/kernel/dma.c:353:10: error: 'direction' undeclared (first
> use in this function)
>   switch (direction) {
>           ^~~~~~~~~
> arch/nds32/kernel/dma.c:358:30: error: 'end' undeclared (first use in
> this function)
>    cpu_dma_inval_range(start, end);
>                               ^~~
> make[1]: *** [arch/nds32/kernel/dma.o] Error 1
> make: *** [arch/nds32/kernel] Error 2
> 
> After this building error, the ftmac100.c driver is broken. Not sure
> what happened.

Christoph used 'direction' as in the original consistent_sync(), but the
parameter is now named 'dir' in the new function. Changing

+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+               size_t size, enum dma_data_direction dir)

to

+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+               size_t size, enum dma_data_direction direction)

(or using 'dir' in place of 'direction' in the switch clauses) should
fix that.

Christoph also forgot to declare and assign 'end'. Adding back the

unsigned long end = start + size;

after

+       unsigned long start = (unsigned long)addr;

should fix the second error.

If your ftmac100 driver relies on the DMA API, it wouldn't be expected
to work if kernel and module views of the DMA API disagree.

HTH,

	Michael

> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
