From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v6 29/36] nds32: Build infrastructure
Date: Tue, 23 Jan 2018 00:00:34 +0800
Message-ID: <CAEbi=3dWeYzGMf2ip9n=7aexojTsX5_nHpAfgL_WpD7qu0HLyg@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e4b231f440511aa0a539ba45f316a096741f530e.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2k18Z5pK-04h4bSVn82m+tvNL4JdtgVT9AJWP5gKXuig@mail.gmail.com>
 <CAEbi=3dZ-Bj+pdhcu1Td1JzgDngyMMeDTFs=XH3LNPnudcUGyg@mail.gmail.com> <CAK8P3a20eqjW3_bQf4eMTwtmJSZ8Vp4agV5O--UkLGXnMhbisQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a20eqjW3_bQf4eMTwtmJSZ8Vp4agV5O--UkLGXnMhbisQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

Hi, Arnd:

2018-01-22 23:38 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 22, 2018 at 4:20 PM, Greentime Hu <green.hu@gmail.com> wrote:
> BE
>>>
>>> I think it's better to drop GENERIC_IRQ_PROBE here, no modern driver
>>> should rely on that.
>>
>> I will drop it.
>>
>>>> +choice
>>>> +       prompt "CPU type"
>>>> +       default CPU_V3
>>>> +config CPU_N15
>>>> +       bool "AndesCore N15"
>>>> +config CPU_N13
>>>> +       bool "AndesCore N13"
>>>> +       select CPU_CACHE_ALIASING if ANDES_PAGE_SIZE_4KB
>>>> +config CPU_N10
>>>> +       bool "AndesCore N10"
>>>> +       select CPU_CACHE_ALIASING
>>>> +config CPU_D15
>>>> +       bool "AndesCore D15"
>>>> +config CPU_D10
>>>> +       bool "AndesCore D10"
>>>> +       select CPU_CACHE_ALIASING
>>>> +config CPU_V3
>>>> +       bool "AndesCore v3 compatible"
>>>> +       select ANDES_PAGE_SIZE_8KB
>>>> +endchoice
>>>
>>> I forget what we discussed here earlier, but at the very least, there should be
>>> some help text here to explain what the implications are. I assume that you
>>> generally want to be able to build one kernel to run on all of the above, right?
>>>
>>> Will selecting 'CPU_V3' result in a kernel binary that can run on all of them?
>>> If so, please explain it here as that is not obvious.
>>>
>>> For the other CPU types, can you list the what backwards-compatiblity
>>> you get? E.g. will a kernel built for N13 run on any of N15, D15 or N10?
>>>
>> Yes, we would like to build a kernel with CPU_V3 to run on all of the above.
>>
>> Not sure if these help texts clear enough?
>>
>> choice
>>         prompt "CPU type"
>>         default CPU_V3
>>         help
>>           The data cache of N15/D15 is implemented as PIPT and it will
>> not cause the
>>           cache aliasing issue. The rest cpus(N13, N10 and D10) are
>> implemented as
>>           VIPT data cache. It may cause the cache aliasing issue if
>> its cache way
>>           size is larger than page size. You can specify the the CPU
>> type direcly or
>>           choose CPU_V3 if unsure.
>>
>>           A kernel built for N10 is able to run on N15, D15, N13, N10 or D10.
>>           A kernel built for N15 is able to run on N15 or D15.
>>           A kernel built for D10 is able to run on D10 or D15.
>>           A kernel built for D15 is able to run on D15.
>>           A kernel built for N13 with CPU_CACHE_ALIASING is able to
>> run on N15, D15, N13, N10 or D10
>>           A kernel built for N13 without CPU_CACHE_ALIASING is able to
>> run on N15, N13 or D15
>>
>> config CPU_N15
>>         bool "AndesCore N15"
>> config CPU_N13
>>         bool "AndesCore N13"
>>         select CPU_CACHE_ALIASING if ANDES_PAGE_SIZE_4KB
>> config CPU_N10
>>         bool "AndesCore N10"
>>         select CPU_CACHE_ALIASING
>> config CPU_D15
>>         bool "AndesCore D15"
>> config CPU_D10
>>         bool "AndesCore D10"
>>         select CPU_CACHE_ALIASING
>> config CPU_V3
>>         bool "AndesCore v3 compatible"
>>         select CPU_CACHE_ALIASING
>> endchoice
>
> I would drop the description about CPU_CACHE_ALIASING in the list
> of compatibilities text and simply say 'A kernel built for N13 is able to run
> on N15, N13 or D15', it's more logical that way, and it gives you the freedom
> to later change the rules about whether it can or cannot run.
>
> Maybe also change the initial prompt from "CPU type" to "minimum CPU type".
>

Thank you for your suggestion.
I will update it like this.

choice
        prompt "minimum CPU type"
        default CPU_V3
        help
          The data cache of N15/D15 is implemented as PIPT and it will not cause
          the cache aliasing issue. The rest cpus(N13, N10 and D10) are
          implemented as VIPT data cache. It may cause the cache aliasing issue
          if its cache way size is larger than page size. You can specify the
          CPU type direcly or choose CPU_V3 if unsure.

          A kernel built for N10 is able to run on N15, D15, N13, N10 or D10.
          A kernel built for N15 is able to run on N15 or D15.
          A kernel built for D10 is able to run on D10 or D15.
          A kernel built for D15 is able to run on D15.
          A kernel built for N13 is able to run on N15, N13 or D15.

config CPU_N15
        bool "AndesCore N15"
config CPU_N13
        bool "AndesCore N13"
        select CPU_CACHE_ALIASING if ANDES_PAGE_SIZE_4KB
config CPU_N10
        bool "AndesCore N10"
        select CPU_CACHE_ALIASING
config CPU_D15
        bool "AndesCore D15"
config CPU_D10
        bool "AndesCore D10"
        select CPU_CACHE_ALIASING
config CPU_V3
        bool "AndesCore v3 compatible"
        select CPU_CACHE_ALIASING
endchoice
