Return-Path: <SRS0=/o7P=4U=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lhrrgout.huawei.com ([185.176.76.210]:2506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729100AbgCCRQW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Mar 2020 12:16:22 -0500
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
 <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org>
 <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <773c5d63-5626-ca3d-634b-73d3a7776ddb@huawei.com>
Date: Tue, 3 Mar 2020 17:16:18 +0000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sinan Kaya <okaya@kernel.org>, "xuwei (O)" <xuwei5@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20200303171618.oKtUB17vmVR9hrFwAHRgW6YpPklvjBC0dz2XF0NO_6Y@z>

On 03/03/2020 16:40, Arnd Bergmann wrote:
> On Tue, Mar 3, 2020 at 2:18 PM John Garry <john.garry@huawei.com> wrote:
>>
>> + linux-arch
>>
>> For background, see
>> https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/
>>
>>>>
>>>> So today only ARM64 uses it for this relevant code, above. But maybe
>>>> others in future will want to use it - any arch without native IO port
>>>> access is a candidate.
>>>
>>> I'm looking at Arnd here for help.
>>>
>>>>
>>>>>
>>>>> As long as the expectations are set, I see no reason why it shouldn't
>>>>> but, I'll let Arnd comment on it too.
>>>>
>>>> ok, so it looks reasonable consider replicating your change for ***, above.
>>
>> To be clear, I would make this change in lib/logic_pio.c since
>> __io_pbr() can be overridden per-arch:
>>
>>    #define BUILD_LOGIC_IO(bw, type)
>>    type logic_in##bw(unsigned long addr)
>>    {
>>         type ret = (type)~0;
>>         if (addr < MMIO_UPPER_LIMIT) {
>> -          ret = read##bw(PCI_IOBASE + addr);
>> +          __io_pbr();
>> +          ret = __raw_read##bw(PCI_IOBASE + addr);
>> +          __io_pbr();
> 
> __io_par();
> 
>>         } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {
>>             struct logic_pio_hwaddr *entry = find_io_range(addr);
>>
>> ...
>>
>> (forgetting leX_to_cpu for the moment)
> 
> Yes, I suppose this is required to get consistent behavior on arm64,
> which overrides __io_par() but not __io_ar(), with the current code
> the barrier after read is weaker when LOGIC_PIO is enabled than it
> is otherwise.

Ok.

Apart from that, this code is somewhat hidden. I mean, most people would 
consider generic IO port accessors come from asm-generic/io.h only, 
which is not the case here. Maybe this can be better integrated into 
asm-generic/io.h, the only hint today being the logic_pio.h include half 
way through the file.

> 
> For other architectures, I suppose we would need another indirection
> level, as those can also override the default inb() itself to do something
> other than readb(PCI_IOBASE + addr), and that is not handled
> here either. We can do that if we need LOGIC_PIO on a second
> architecture.

Jiaxun Yang did mention that MIPS may want to move away from its own IO 
space management.

Thanks,
John
