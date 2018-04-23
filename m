Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42060 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755173AbeDWLDu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Apr 2018 07:03:50 -0400
Received: by mail-vk0-f66.google.com with SMTP id g6so9090421vkb.9
        for <linux-arch@vger.kernel.org>; Mon, 23 Apr 2018 04:03:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e78c09ad-ce68-a8ed-3cd9-2577c6e5539b@gmail.com>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-14-hch@lst.de>
 <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com> <e78c09ad-ce68-a8ed-3cd9-2577c6e5539b@gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Mon, 23 Apr 2018 19:03:09 +0800
Message-ID: <CAEbi=3f2QJDdsC+0NEJSoP9n2GAR+sju2H8BJ9sUQprzmY-x8g@mail.gmail.com>
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>

2018-04-23 16:09 GMT+08:00 Michael Schmitz <schmitzmic@gmail.com>:
> Hi
>
> Am 23.04.2018 um 18:49 schrieb Greentime Hu:
>> 2018-04-20 16:03 GMT+08:00 Christoph Hellwig <hch@lst.de>:
>>> Switch to the generic noncoherent direct mapping implementation.
>>>
>>> This makes sure kmap_atomic_pfn is consistently used for access to
>>> virtual addresses instead of either using the slower plain kmap
>>> or blindly expecting page_address() to work.
>>>
>>> This makes sure the cache_sync routines is called in the unmap_sg
>>> case, to match the unmap_single and sync_{single,sg}_to_cpu cases.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>>   CC      arch/nds32/kernel/dma.o
>> arch/nds32/kernel/dma.c: In function 'arch_sync_dma_for_device':
>> arch/nds32/kernel/dma.c:333:10: error: 'direction' undeclared (first
>> use in this function)
>>   switch (direction) {
>>           ^~~~~~~~~
>> arch/nds32/kernel/dma.c:333:10: note: each undeclared identifier is
>> reported only once for each function it appears in
>> arch/nds32/kernel/dma.c: In function 'arch_sync_dma_for_cpu':
>> arch/nds32/kernel/dma.c:353:10: error: 'direction' undeclared (first
>> use in this function)
>>   switch (direction) {
>>           ^~~~~~~~~
>> arch/nds32/kernel/dma.c:358:30: error: 'end' undeclared (first use in
>> this function)
>>    cpu_dma_inval_range(start, end);
>>                               ^~~
>> make[1]: *** [arch/nds32/kernel/dma.o] Error 1
>> make: *** [arch/nds32/kernel] Error 2
>>
>> After this building error, the ftmac100.c driver is broken. Not sure
>> what happened.
>
> Christoph used 'direction' as in the original consistent_sync(), but the
> parameter is now named 'dir' in the new function. Changing
>
> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +               size_t size, enum dma_data_direction dir)
>
> to
>
> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +               size_t size, enum dma_data_direction direction)
>
> (or using 'dir' in place of 'direction' in the switch clauses) should
> fix that.
>
> Christoph also forgot to declare and assign 'end'. Adding back the
>
> unsigned long end = start + size;
>
> after
>
> +       unsigned long start = (unsigned long)addr;
>
> should fix the second error.
>
> If your ftmac100 driver relies on the DMA API, it wouldn't be expected
> to work if kernel and module views of the DMA API disagree.
>
> HTH,
>
>         Michael
>

Hi, Micchael:

Thank you for helping fixing this build error.
What I mean before is that I fixed this build error just like what you
did and I built-in the ftmac100 driver as default in defconfig.
However the dhcpc failed, it works in Linux 4.17-rc1. I am still
debugging it. I use ftmac100 to test because it's the only driver I
can use for now and which will use DMA.
