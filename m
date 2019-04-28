Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:18867
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbfD1OJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Apr 2019 10:09:07 -0400
Subject: Re: endianness swapped
References: <20190427153222.GA9613@jerusalem>
 <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org>
Date: Sun, 28 Apr 2019 23:59:39 +1000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Angelo Dureghello <angelo@sysam.it>, Logan Gunthorpe <logang@deltatee.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg KH <gregkh@linuxfoundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190428135939.s8Z_WxSd7KwiOkwyXKAZLk0D0ChyZi8CGPvy8yODE-w@z>


On 28/4/19 7:21 pm, Arnd Bergmann wrote:
> On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
>>> On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
>>>> as you may know, i am working on mcf5441x.
>>>> Sorry for not following carefully all the threads, but from a certain
>>>> kernel version (likely 4.19 or near there), seems ioread32be
>>>> reads the bytes swapped in endianness (mcf-edma dma driver not working
>>>> anymore).
>>>>
>>>> Has there been a change about this in the architecture I/O access ?
>>>> How should i proceed now ? Fixing the DMA driver read/write, or what ?
>>
>>> looks like the reason of my ioread32be now swapped is:
>>>
>>> https://patchwork.kernel.org/patch/10766673/
>>>
>>> Trying to figure out what to do now.
>>
>> This is commit aecc787c06f4300f ("iomap: Use non-raw io functions for
>> io{read|write}XXbe"):
>>
>> --- a/lib/iomap.c
>> +++ b/lib/iomap.c
>> @@ -65,8 +65,8 @@ static void bad_io_access(unsigned long port, const
>> char *access)
>>   #endif
>>
>>   #ifndef mmio_read16be
>> -#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
>> -#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
>> +#define mmio_read16be(addr) swab16(readw(addr))
>> +#define mmio_read32be(addr) swab32(readl(addr))
>>   #endif
>>
>>   unsigned int ioread8(void __iomem *addr)
>> @@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
>>   #endif
>>
>>   #ifndef mmio_write16be
>> -#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
>> -#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
>> +#define mmio_write16be(val,port) writew(swab16(val),port)
>> +#define mmio_write32be(val,port) writel(swab32(val),port)
>>
>> On big endian, the raw accessors are assumed to be non-swapping,
>> while non-raw accessors are assumed to be swapping.
>> The latter is not true for Coldfire internal registers, cfr.
>> arch/m68k/include/asm/io_no.h:
> 
> The raw accessors are always assumed to be non-swapping
> in the asm-generic code, while the non-raw ones are assumed to
> be little-endian in order for them to work with portable drivers.
> 
> We have some other cases of big-endian machines that use
> a hardware byteswap on their MMIO buses (iirc some mips
> and superh parts), but they then need to swap the __raw_*
> accessor data words in software to get back to the normal
> behavior, as well as swizzle the address for accesses that are
> less than 32 bit wide.
> 
> Coldfire makes the behavior of readw()/readl() depend on the
> MMIO address, presumably since that was the easiest way to
> get drivers working originally, but it breaks the assumption
> in the asm-generic code.

Yes, that is right.

There is a number of common hardware modules that Freescale have
used in the ColdFire SoC parts and in their ARM based parts (iMX
families). The ARM parts are pretty much always little endian, and
the ColdFire is always big endian. The hardware registers in those
hardware blocks are always accessed in native endian of the processor.

So the address range checks are to deal with those internal
hardware blocks (i2c, spi, dma, etc), since we know those are
at fixed addresses. That leaves the usual endian swapping in place for
other general (ie external) devices (PCI devices, network chips, etc).


>> static inline u16 readw(const volatile void __iomem *addr)
>> {
>>          if (cf_internalio(addr))
>>                  return __raw_readw(addr);
>>          return __le16_to_cpu(__raw_readw(addr));
>> }
>>
>> Orthogonal to how Coldfire's read[wl]() should be fixed, I find it a bit
>> questionable to swap data twice on big endian architectures.
> 
> I would expect that the compiler is capable of detecting a double
> swap and optimize it out. Even if it can't, there are not that many
> instances of io{read,write}{16,32}be in the kernel, so the increase
> in kernel image size from a double swap should be limited to a
> few extra instructions, and the runtime overhead should be
> negligible compared to the bus access.
> 
>> Fortunately we can avoid that by defining our own
>> mmio_{read,write}{16,32}be()...

Makes sense.

Regards
Greg
