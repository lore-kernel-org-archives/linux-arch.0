Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58260 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfDZTGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Apr 2019 15:06:24 -0400
Subject: Re: [tech-privileged] [PATCH] riscv: Support non-coherency memory
 model
References: <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de> <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
 <20190424020803.GA27332@guoren-Inspiron-7460>
 <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
 <20190424055703.GA3417@guoren-Inspiron-7460>
 <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
 <20190424142306.GB20974@lst.de>
 <CAK8P3a36V93mKLuR-6hZzNX+j0HVpR_9bM41653PQuD+1xMTVw@mail.gmail.com>
 <20190426160558.GA10540@guoren-Inspiron-7460>
 <CAK8P3a2CvvBMZ8UkkgyrczgUccSGZ35RpG8V2dGUXbuOh9AZ5A@mail.gmail.com>
From: Bill Huffman <huffman@cadence.com>
Message-ID: <84539a72-3fa7-2aad-330b-fb9b15b9cd61@cadence.com>
Date: Fri, 26 Apr 2019 12:05:16 -0700
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2CvvBMZ8UkkgyrczgUccSGZ35RpG8V2dGUXbuOh9AZ5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Gary Guo <gary@garyguo.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew Waterman <andrew@sifive.com>, Anup Patel <anup.patel@wdc.com>, Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vincent Chen <vincentc@andestech.com>, Greentime Hu <green.hu@gmail.com>, "ren_guo@c-sky.com" <ren_guo@c-sky.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Scott Wood <swood@redhat.com>, "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Message-ID: <20190426190516.sWCzuqHw8kZfBjvvOyVi185Hr489BhEvGqLk8t7h930@z>



On 4/26/19 11:42 AM, Arnd Bergmann wrote:
> EXTERNAL MAIL
> 
> 
> On Fri, Apr 26, 2019 at 6:06 PM Guo Ren <guoren@kernel.org> wrote:
>> On Thu, Apr 25, 2019 at 11:50:11AM +0200, Arnd Bergmann wrote:
>>> On Wed, Apr 24, 2019 at 4:23 PM Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> You could probably get away with allowing uncached mappings only
>>> for huge pages, and using one or two of the bits the PMD for it.
>>> This should cover most use cases, since in practice coherent allocations
>>> tend to be either small and rare (device descriptors) or very big
>>> (frame buffer etc), and both cases can be handled with hugepages
>>> and gen_pool_alloc, possibly CMA added in since there will likely
>>> not be an IOMMU either on the systems that lack cache coherent DMA.
>>
>> Generally attributs in huge-tlb-entry and leaf-tlb-entry should be the
>> same. Only put _PAGE_CACHE and _PAGE_BUF bits in huge-tlb-entry sounds
>> a bit strange.
> 
> Well, the point is that we can't really change the meaning of the existing
> low bits, but because of the alignment contraints on hugepages, the extra bits
> are currently unused for hugepage TLBs.
> There are other architectures that reuse the bits in clever ways, e.g.
> allowing larger physical address ranges to be used with hugepages than
> normal pages.
> 
>> The gen_pool_alloc only 256KB by default, but a huge tlb entry is 4MB.
>> Hardware couldn't setup vitual-4MB to a phys-256KB range mapping in TLB.
> 
> I expect the size would be easily changed, as long as there is sufficient
> physical memory. If the entire system has 32MB or less, setting 2MB aside
> would have a fairly significant impact of course.
> 
> 
>>> - you need to decide what is supposed to happen when there are
>>>    multiple conflicting mappings for the same physical address.
>>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> What's the mulitple confilcing mappings ?
> 
> I mean when you have the linear mapping as cacheable and another
> mapping for the same physical page as uncacheable, and then access
> virtual address in both. This is usually a bad idea, but architectures
> go to different lengths to prevent it.
> 
> The safest way would be for the CPU to produce a checkstop as soon
> as there are TLB entries for the same physical address but different
> caching settings. You can also do that if you have a cache-bypassing
> load/store that hits a live cache line.

The second one is probably do-able in most systems.  But the first one 
usually isn't.  The TLB usually can't be looked up by physical address.

       Bill

> 
> The other extreme would be to not do anything special and try to come
> up with sane behavior, e.g. allow accesses in both ways but ensure that
> a cache-bypassing load/store always flushes and invalidates cache
> lines for the same physical address before its access.
> 
>         Arnd
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> 
> View/Reply Online (#395): https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.riscv.org_g_tech-2Dprivileged_message_395&d=DwIBaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=AYJ4kbebphYpRw2lYDUDCk5w5Qa3-DR3bQnFjLVmM80&m=zf51zm7BmTNIb87ycEVTpGbwXV6ovRb4Rqy-BVXZ2F4&s=IWaqMk0fwM69syrjjmqzm5u3GeI_wWUYTJfBXCbxnWA&e=
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.riscv.org_mt_31344322_1677293&d=DwIBaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=AYJ4kbebphYpRw2lYDUDCk5w5Qa3-DR3bQnFjLVmM80&m=zf51zm7BmTNIb87ycEVTpGbwXV6ovRb4Rqy-BVXZ2F4&s=BwJEwbhCkTjHFPfiAQs7CBgG1U6kqM7yZbpSWXPTOoU&e=
> Group Owner: tech-privileged+owner@lists.riscv.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.riscv.org_g_tech-2Dprivileged_unsub&d=DwIBaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=AYJ4kbebphYpRw2lYDUDCk5w5Qa3-DR3bQnFjLVmM80&m=zf51zm7BmTNIb87ycEVTpGbwXV6ovRb4Rqy-BVXZ2F4&s=vSG91zravGfrVN9_elxveQPGPYaNew0MyETUvHfKSEk&e=  [huffman@cadence.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
