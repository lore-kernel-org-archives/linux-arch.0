From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 13/31] nds32: DMA mapping API
Date: Fri, 10 Nov 2017 16:13:13 +0800
Message-ID: <CAEbi=3cdWLfZKPmELwR_P5gDa_ocJZPoexj7N4QnuDfwx4crtQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <763e6a252de1ad8ccd28344fd0676ae2f92f796d.1510118606.git.green.hu@gmail.com>
 <CAK8P3a11a+So5DUZwv+geT2WMYpMG-FPt9=nKZFyYLQ0Gs55qw@mail.gmail.com>
 <CAEbi=3ebX94-eHa56+ktvbp3Obbe_Uwva8tiPrZvQT-x+QnZzQ@mail.gmail.com> <CAK8P3a0BVWgUvHnJwfgUYbc9ZZqmCaG3XVe0thXX6kaaPFpZ_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:53649 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdKJINy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Nov 2017 03:13:54 -0500
In-Reply-To: <CAK8P3a0BVWgUvHnJwfgUYbc9ZZqmCaG3XVe0thXX6kaaPFpZ_g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, deanbo422@gmail.com

2017-11-09 18:14 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thu, Nov 9, 2017 at 8:12 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2017-11-08 17:09 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>
>
>>> You do the same cache operations for _to_cpu and _to_device, which
>>> usually works,
>>> but is more expensive than you need. It's better to take the ownership into
>>> account and only do what you need.
>>>
>> Like this?
>>
>> static void
>> nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
>>                               size_t size, enum dma_data_direction dir)
>> {
>>         consistent_sync((void *)dma_to_virt(dev, handle), size,
>> DMA_FROM_DEVICE);
>> }
>>
>> static void
>> nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
>>                                  size_t size, enum dma_data_direction dir)
>> {
>>         consistent_sync((void *)dma_to_virt(dev, handle), size,
>> DMA_TO_DEVICE);
>> }
>
> No, it's more complicated than that. You need to pass both the direction of the
> DMA transaction and the ownership to consistent_sync(), and then do the
> correct cache maintenance operation for each of the six combinations.
>
> Which operation that is depends on the microarchitecture to some degree,
> e.g. on machines that can load arbitrary cache lines during speculative
> execution, you have to invalidate the caches during both
> _for_device/FROM_DEVICE _for_cpu/FROM_DEVICE, while machines
> without speculative execution can skip the second invalidation, they
> only need to get rid of dirty cache lines before the DMA from device.
>
> Usually you don't have to do a writeback during _for_cpu, since there
> are no dirty cache lines after the _for_device operation.
>
> It's not entirely clear what the correct behavior is for buffers that
> are not cache line aligned, some architectures use wbinval instead
> of inval for the _for_device/_FROM_DEVICE operation, on
> any partial cache line, but you wouldn't want to do that on the
> _for_cpu/_FROM_DEVICE operation.


I get your point. I prefer to keep it that way because it will be a
little bit complex.
I will still study the code to see what I can improve in the next version patch.
