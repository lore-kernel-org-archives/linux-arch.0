From: John Garry <john.garry@huawei.com>
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
Date: Fri, 6 Mar 2020 16:18:33 +0000
Message-ID: <182a37c2-7437-b1bd-8b86-5c9ce2e29f00@huawei.com>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
 <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org>
 <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
 <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org>
 <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
 <ae0a1bf1-948f-7df0-9efb-cd1e94e27d2d@huawei.com>
 <CAK8P3a2wdCrBP=a8ZypWoC=HyCU3oYYNeCddWM7oT+xM9gTPhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([185.176.76.210]:2515 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbgCFQSh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 11:18:37 -0500
In-Reply-To: <CAK8P3a2wdCrBP=a8ZypWoC=HyCU3oYYNeCddWM7oT+xM9gTPhw@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sinan Kaya <okaya@kernel.org>, "xuwei (O)" <xuwei5@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>

On 06/03/2020 15:16, Arnd Bergmann wrote:
> On Fri, Mar 6, 2020 at 11:40 AM John Garry <john.garry@huawei.com> wrote:
>> On 06/03/2020 07:54, Arnd Bergmann wrote:
>>> On Fri, Mar 6, 2020 at 4:44 AM Sinan Kaya <okaya@kernel.org> wrote:
>> -- a/lib/logic_pio.c
>> +++ b/lib/logic_pio.c
>> @@ -229,13 +229,21 @@ unsigned long
>> logic_pio_trans_cpuaddr(resource_size_t addr)
>>    }
>>
>>    #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
>> +
>> +#define logic_in_to_cpu_b(x) (x)
>> +#define logic_in_to_cpu_w(x) __le16_to_cpu(x)
>> +#define logic_in_to_cpu_l(x) __le32_to_cpu(x)
>> +
>>    #define BUILD_LOGIC_IO(bw, type)                                      \

Note: The "bw" argument name could be improved to "bwl", since this 
macro is used for building inl() also.

>>    type logic_in##bw(unsigned long addr)                                 \
>>    {                                                                     \
>>           type ret = (type)~0;                                           \
>>                                                                          \
>>           if (addr < MMIO_UPPER_LIMIT) {                                 \
>> -               ret = read##bw(PCI_IOBASE + addr);                     \
>> +               void __iomem *_addr = PCI_IOBASE + addr;               \
>> +               __io_pbr();                                            \
>> +               ret = logic_in_to_cpu_##bw(__raw_read##bw(_addr));     \
>> +               __io_par(ret);                                         \
>>           } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {\
>>                   struct logic_pio_hwaddr *entry = find_io_rang
>>
>> We could prob combine the le_to_cpu and __raw_read into a single macro.
> 
> What is the purpose of splitting out the byteswap rather than leaving the
> open-coded rather than __le16_to_cpu(__raw_readw(PCI_IOBASE + addr))?

I'm just copying what is in asm-generic io.h, which uses the 16b and 32b 
byteswaps in the w and l variants, respectively.

> 
> If this is needed to work across architectures, how about adding
> an intermediate __raw_inw() etc in asm-generic/io.h like
> 
> #ifndef __raw_inw
> #define __raw_inw(a) __raw_readw(PCI_IOBASE + addr));
> #endif
> 
> #include <linux/logic_pio.h>
> 
> #ifndef inw
> static inline u16 inw(unsigned long addr)
> {
>          u16 val;
> 
>          __io_pbr();
>          val = __le16_to_cpu(__raw_inw(addr));
>          __io_par(val);
>          return val;
> }
> #endif
> 

The idea is good, but it would be nice if we just somehow use a common 
asm-generic io.h definition directly in logic_pio.c, like:

asm-generic io.h:

#ifndef __raw_inw // name?
#define __raw_inw __raw_inw
static inline u16 __raw_inw(unsigned long addr)
{
	u16 val;

	__io_pbr();
	val = __le16_to_cpu(__raw_readw(addr));
	__io_par(val);
	return val;
}
#endif

#include <linux/logic_pio.h>

#ifndef inw
#define inw __raw_inw
#endif

logic_pio.c:

  #define BUILD_LOGIC_IO(bw, type)                                      \
  type logic_in##bw(unsigned long addr)                                 \
  {                                                                     \
         type ret = (type)~0;                                           \
                                                                        \
         if (addr < MMIO_UPPER_LIMIT) {                                 \
-               ret = read##bw(PCI_IOBASE + addr);                     \
+               ret = __raw_in##bw(PCI_IOBASE + addr);                 \
         } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {\
                 struct logic_pio_hwaddr *entry = find_io_rang

Thanks,
John
