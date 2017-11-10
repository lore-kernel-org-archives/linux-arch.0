From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 26/31] nds32: Build infrastructure
Date: Fri, 10 Nov 2017 16:26:58 +0800
Message-ID: <CAEbi=3c7tduSHQ2HEAfcJF8A3QPD493_gHPK=_WiQGtSr0bc=A@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <7278eca76456b412e02d9baa5dc164e83199cbab.1510118606.git.green.hu@gmail.com>
 <CAK8P3a11Mk3XcmP5Ecbv55TuNRjrrp_43GX8hPDfdLh6JMHE=g@mail.gmail.com>
 <CAEbi=3d91XPe0oGFfSB0T4tCU9FN=0SNLk7xKFifrV+-06u8AA@mail.gmail.com> <CAK8P3a3i+_ZRcR9ab=Pf26R+1JKuzz3VKQxA=mL131KDCpobHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3i+_ZRcR9ab=Pf26R+1JKuzz3VKQxA=mL131KDCpobHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

2017-11-09 18:33 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thu, Nov 9, 2017 at 10:02 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2017-11-08 18:16 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>
>>>> +config GENERIC_CALIBRATE_DELAY
>>>> +       def_bool y
>>>
>>> It's better to avoid the delay loop completely and skip the calibration,
>>> if your hardware allows.
>>
>> Thanks.
>> Do you mean that this config should be def_bool n?
>> why? Almost all arch enable it.
>
> It depends on what your hardware can do. If you have a way to see how much
> time has passed that is guaranteed to be reliable on all machines, then
> use that instead.
>
> On a lot of architectures, it's not possible, so they have to fall back to using
> the delay loop.

I get it. I will discuss it with our HW colleagues.
We may get these informations in some registers.

>>>> +config ALIGNMENT_TRAP
>>>> +       tristate "Kernel support unaligned access handling"
>>>> +       default y
>>>> +       help
>>>> +         Andes processors cannot fetch/store information which is not
>>>> +         naturally aligned on the bus, i.e., a 4 byte fetch must start at an
>>>> +         address divisible by 4. On 32-bit Andes processors, these non-aligned
>>>> +         fetch/store instructions will be emulated in software if you say
>>>> +         here, which has a severe performance impact. This is necessary for
>>>> +         correct operation of some network protocols. With an IP-only
>>>> +         configuration it is safe to say N, otherwise say Y.
>>>
>>> Which network protocols are you referring to?
>>
>> I will modify these descriptions. It was written by someone I don't know. :p
>> This case only happened when I found is compiler code gen issue or
>> wrong pointer usage.
>
> Ok, should it also be 'default n' then?

Yup. I will use 'default n' in the next version patch.

>>>> +config HIGHMEM
>>>> +       bool "High Memory Support"
>>>> +       depends on MMU && CPU_CACHE_NONALIASING
>>>> +       help
>>>> +         The address space of Andes processors is only 4 Gigabytes large
>>>> +         and it has to accommodate user address space, kernel address
>>>> +         space as well as some memory mapped IO. That means that, if you
>>>> +         have a large amount of physical memory and/or IO, not all of the
>>>> +         memory can be "permanently mapped" by the kernel. The physical
>>>> +         memory that is not permanently mapped is called "high memory".
>>>> +
>>>> +         Depending on the selected kernel/user memory split, minimum
>>>> +         vmalloc space and actual amount of RAM, you may not need this
>>>> +         option which should result in a slightly faster kernel.
>>>> +
>>>> +         If unsure, say N.
>>>
>>> Generally speaking, highmem support is a mess, and it's better to avoid it.
>>>
>>> I see that the two device tree files you have list 1GB of memory. Do you think
>>> that is a common configuration for actual products? Do you expect any to
>>> have more than 1GB (or more than 4GB) in the future, or is that the upper
>>> end of the scale?
>>>
>>> If 1GB is a reasonable upper bound, then you could change the vmsplit
>>> to give slightly less address space to user space and have 1GB of direct-mapped
>>> kernel memory plus 256MB of vmalloc space reserved for the kernel,
>>> and completely avoid highmem.
>>
>> Thanks.
>> We do realy use 1GB ram in some products.
>> We also verify CONFIG_HIGHMEM with LTP too.
>> It seems fine but I will study vmsplit to see if we should use it.
>
> For the 1GB configuration, something like ARM's CONFIG_VMSPLIT_3G_OPT
> should be optimal, it will result in better performance because it allows you
> to completely turn off CONFIG_HIGHMEM. The reason we don't always
> use it on ARM is that traditionally we had the 3GB vmsplit, and some
> applications
> might rely on having the exact amount of available address space that they
> expect. For a new architecture that should be less of a problem.
>
> The interesting case is what happens if you have machines with 1.5GB or
> or more physical RAM. You can obviously have another vmsplit configuration
> for those, but at some point going to highmem is better than limiting the
> user address space.
>
> Ideally 1.5GB is the point where you start using a 64-bit CPU, but of course
> that is not something you have available at the moment.



>>>> +config MEMORY_START
>>>> +       hex "Physical memory start address"
>>>> +       default "0x00000000"
>>>> +       help
>>>> +         Physical memory start address, you may modify it if it is porting to
>>>> +         a new SoC with different start address.
>>>> +endmenu
>>>
>>> On ARM, we found options like this to be rather problematic since it prevents
>>> you from running the same kernel on boards that are otherwise compatible.
>>>
>>> If the architecture easily allows the memory to start at address 0, could
>>> you require this address for all SoCs that want to run Linux, and get
>>> rid of the compile-time option?
>>
>> Thanks.
>> The reason we need this config is because we need to define PHYS_OFFSET.
>> #define PHYS_OFFSET     (CONFIG_MEMORY_START)
>>
>> It needs to be set in compile-time. I don't know how to get rid of it.
>
> PHYS_OFFSET doesn't have to be a constant, a lot of architectures make
> the __va()/__pa() and related functions use a variable for the offset.
> This is also useful to implement KASLR, and booting the kernel from
> a random physical address.
>
> My actual suggestion however was to just mandate that PHYS_OFFSET
> is always zero for your architecture, and not support any other value.
> This is easy as long as you don't have existing hardware that would
> break.

Thanks.
I will check how other architectures do.
I can mandate that PHYS_OFFSET is zero but our customers(SoC company)
may not use 0x0 as default DRAM starting address.
This assumption is a little bit too strong.
