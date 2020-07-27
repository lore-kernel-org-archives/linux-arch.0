From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] io: Fix return type of _inb and _inl
Date: Mon, 27 Jul 2020 09:28:25 +0100
Message-ID: <a55f21a7-aff9-09a9-2fcd-c9ef76728116@huawei.com>
References: <20200726031154.1012044-1-shorne@gmail.com>
 <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
 <20200726125325.GC80756@lianli.shorne-pla.net>
 <CAK8P3a0-wPsVi-fXPW4Dghn30cumrzvLujp7usio50EHmCHM=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0-wPsVi-fXPW4Dghn30cumrzvLujp7usio50EHmCHM=g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Wei Xu <xuwei5@hisilicon.com>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 27/07/2020 09:04, Arnd Bergmann wrote:> On Sun, Jul 26, 2020 at 2:53 
PM Stafford Horne <shorne@gmail.com> wrote:
>>
>> On Sun, Jul 26, 2020 at 12:00:37PM +0300, Andy Shevchenko wrote:
>>> On Sun, Jul 26, 2020 at 6:14 AM Stafford Horne <shorne@gmail.com> wrote:
>>>>
>>>> The return type of functions _inb, _inw and _inl are all u16 which looks
>>>> wrong.  This patch makes them u8, u16 and u32 respectively.
>>>>
>>>> The original commit text for these does not indicate that these should
>>>> be all forced to u16.
>>>
>>> Is it in alight with all architectures? that support this interface natively?
>>>
>>> (Return value is arch-dependent AFAIU, so it might actually return
>>> 16-bit for byte read, but I agree that this is weird for 32-bit value.
>>> I think you have elaborate more in the commit message)
>>
>> Well, this is the generic io code,  at least these api's appear to not be different
>> for each architecture.  The output read by the architecture dependant code i.e.
>> __raw_readb() below is getting is placed into a u8.  So I think the output of
>> the function will be u8.
>>
>> static inline u8 _inb(unsigned long addr)
>> {
>>          u8 val;
>>
>>          __io_pbr();
>>          val = __raw_readb(PCI_IOBASE + addr);
>>          __io_par(val);
>>          return val;
>> }
>>
>> I can expand the commit text, but I would like to get some comments from the
>> original author to confirm if this is an issue.
> 
> I think your original version is fine, this was clearly just a typo and I've
> applied your fix now and will forward it to Linus in the next few days,
> giving John the chance to add his Ack or further comments.
> 
> Thanks a lot for spotting it and sending a fix.

Thanks Arnd.

Yeah, these looks like copy+paste errors on my part:

Reviewed-by: John Garry <john.garry@huawei.com>

I'll give this patch a spin, but not expecting any differences (since 
original seems ok).

Note that kbuild robot also reported this:
https://lore.kernel.org/lkml/202007140549.J7X9BVPT%25lkp@intel.com/

Extract:

include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in 
argument 1 (different base types) @@     expected unsigned int 
[usertype] value @@     got restricted __le32 [usertype] @@
    include/asm-generic/io.h:521:22: sparse:     expected unsigned int 
[usertype] value
    include/asm-generic/io.h:521:22: sparse:     got restricted __le32 
[usertype]

But they look like issues which were in the existing code. I tried to 
recreate to verify any change, but trying to manually upgrade glibc 
busted my machine :(

Thanks,
John
