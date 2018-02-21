Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37584 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeBUMDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2018 07:03:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2pQTFiJ9Sr9pLFx-qFv1PAAs+KyPiRuB3qTLmtY2ZhYw@mail.gmail.com>
References: <ff404658ececd53f1bf111067c587c4e3eb695af.1518505384.git.greentime@andestech.com>
 <201802161853.FKQRlYLX%fengguang.wu@intel.com> <CAEbi=3fMVLgqMxg5ru=Nd7YHTHs7YvirorT-zEtdBpMkuWHLyg@mail.gmail.com>
 <CAK8P3a2pQTFiJ9Sr9pLFx-qFv1PAAs+KyPiRuB3qTLmtY2ZhYw@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 21 Feb 2018 20:02:42 +0800
Message-ID: <CAEbi=3eAkOeB=Hb93ekPwqBLENNDxWutxJnJHaC=3KAV_P6kJA@mail.gmail.com>
Subject: Re: [PATCH v7 02/37] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 out of ifndef CONFIG_MMU
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>

2018-02-21 19:37 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Feb 21, 2018 at 12:21 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2018-02-16 18:47 GMT+08:00 kbuild test robot <lkp@intel.com>:
>
>>
>> From: Greentime Hu <greentime@andestech.com>
>> Date: Wed, 21 Feb 2018 14:21:23 +0800
>> Subject: [PATCH] xtensa: add ioremap_nocache declaration before include
>>  asm-generic/io.h.
>>
>> A future commit for the nds32 architecture bootstrap("asm-generic/io.h:
>> move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef
>> CONFIG_MMU") will move the ioremap_nocache out of the CONFIG_MMU ifdef.
>> This means that in order to suppress re-definition errors we need to
>> setup #define's before importing asm-generic/io.h.
>>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> Don't you need to override both ioremap and ioremap_nocache?

Hi, Arnd:

It can fix the building error to override ioremap_nocache.
Why should I override ioremap?

Do you mean remove this implementation
"
static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
{
        return ioremap_nocache(offset, size);
}
"
and replace it with
#define ioremap ioremap_nocache

Because I think this patch is just used to fix the build error.
Thank you.

>> ---
>>  arch/xtensa/include/asm/io.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
>> index c38e5a732d86..acc5bb2cf1c7 100644
>> --- a/arch/xtensa/include/asm/io.h
>> +++ b/arch/xtensa/include/asm/io.h
>> @@ -52,6 +52,7 @@ static inline void __iomem *ioremap_cache(unsigned
>> long offset,
>>                 return xtensa_ioremap_cache(offset, size);
>>  }
>>  #define ioremap_cache ioremap_cache
>> +#define ioremap_nocache ioremap_nocache
>>
>>  #define ioremap_wc ioremap_nocache
