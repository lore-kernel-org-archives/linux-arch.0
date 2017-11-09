From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 26/31] nds32: Build infrastructure
Date: Thu, 9 Nov 2017 17:02:54 +0800
Message-ID: <CAEbi=3d91XPe0oGFfSB0T4tCU9FN=0SNLk7xKFifrV+-06u8AA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <7278eca76456b412e02d9baa5dc164e83199cbab.1510118606.git.green.hu@gmail.com>
 <CAK8P3a11Mk3XcmP5Ecbv55TuNRjrrp_43GX8hPDfdLh6JMHE=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:43506 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdKIJDg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Nov 2017 04:03:36 -0500
In-Reply-To: <CAK8P3a11Mk3XcmP5Ecbv55TuNRjrrp_43GX8hPDfdLh6JMHE=g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

2017-11-08 18:16 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>
>> diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
>> new file mode 100644
>> index 0000000..112f470
>> --- /dev/null
>> +++ b/arch/nds32/Kconfig
>> @@ -0,0 +1,107 @@
>> +#
>> +# For a description of the syntax of this configuration file,
>> +# see Documentation/kbuild/kconfig-language.txt.
>> +#
>> +
>> +config NDS32
>> +        def_bool y
>> +       select ARCH_HAS_RAW_COPY_USER
>> +       select ARCH_WANT_FRAME_POINTERS if FTRACE
>> +       select ARCH_WANT_IPC_PARSE_VERSION
>> +       select CLKSRC_MMIO
>> +       select CLONE_BACKWARDS
>> +       select TIMER_OF
>> +       select FRAME_POINTER
>> +       select GENERIC_ATOMIC64
>> +       select GENERIC_CPU_DEVICES
>> +       select GENERIC_CLOCKEVENTS
>> +       select GENERIC_IOMAP
>> +       select GENERIC_IRQ_CHIP
>> +       select GENERIC_IRQ_PROBE
>> +       select GENERIC_IRQ_SHOW
>> +       select GENERIC_STRNCPY_FROM_USER
>> +       select GENERIC_STRNLEN_USER
>> +       select GENERIC_TIME_VSYSCALL
>> +       select HAVE_ARCH_TRACEHOOK
>> +       select HAVE_GENERIC_IOMAP
>
> You normally don't want HAVE_GENERIC_IOMAP, at least unless the CPU
> has special instructions to trigger PCI I/O port access.

Thanks.
I will remove it in the next version patch.

>> +       select HAVE_DEBUG_KMEMLEAK
>> +       select HAVE_IDE
>
> You certainly don't want HAVE_IDE

Thanks.
I will remove it in the next version patch.

>> +       select HAVE_MEMBLOCK
>> +       select HAVE_MEMBLOCK_NODE_MAP
>> +       select HAVE_UID16
>
> HAVE_UID16 shouldn't be used on new architectures, as mentioned in the
> comment about asm/posix_types.h

Thanks.
I will remove it in the next version patch.

>> +       select HAVE_REGS_AND_STACK_ACCESS_API
>> +       select IRQ_DOMAIN
>> +       select LOCKDEP_SUPPORT
>> +       select MODULES_USE_ELF_REL
>> +       select MODULES_USE_ELF_RELA
>
> I would think that you use either MODULES_USE_ELF_REL or
> MODULES_USE_ELF_RELA, but not both.

Thanks.
I will check which one we used and remove the other one if posible.

>> +       select OF
>> +       select OF_EARLY_FLATTREE
>> +       select OLD_SIGACTION
>> +       select OLD_SIGSUSPEND3
>
> What are the OLD_SIG* ones for? It sounds like something you shouldn't
> need, although I'm not familiar wiht them.

Thanks I will check if we need it or not.

>> +       select NO_IOPORT_MAP
>> +       select RTC_LIB
>> +       select THREAD_INFO_IN_TASK
>> +       select SYS_SUPPORTS_APM_EMULATION
>
> I don't see what SYS_SUPPORTS_APM_EMULATION gains you.

Thanks.
I will remove it in the next version patch.

>> +config GENERIC_CALIBRATE_DELAY
>> +       def_bool y
>
> It's better to avoid the delay loop completely and skip the calibration,
> if your hardware allows.

Thanks.
Do you mean that this config should be def_bool n?
why? Almost all arch enable it.

>> +
>> +config NDS32_BUILTIN_DTB
>> +        string "Builtin DTB"
>> +        default ""
>> +       help
>> +         User can use it to specify the dts of the SoC
>
> Better leave this up to the boot loader.

Thanks.
uboot will pass it too.

>> +config ALIGNMENT_TRAP
>> +       tristate "Kernel support unaligned access handling"
>> +       default y
>> +       help
>> +         Andes processors cannot fetch/store information which is not
>> +         naturally aligned on the bus, i.e., a 4 byte fetch must start at an
>> +         address divisible by 4. On 32-bit Andes processors, these non-aligned
>> +         fetch/store instructions will be emulated in software if you say
>> +         here, which has a severe performance impact. This is necessary for
>> +         correct operation of some network protocols. With an IP-only
>> +         configuration it is safe to say N, otherwise say Y.
>
> Which network protocols are you referring to?

I will modify these descriptions. It was written by someone I don't know. :p
This case only happened when I found is compiler code gen issue or
wrong pointer usage.

>> +config HIGHMEM
>> +       bool "High Memory Support"
>> +       depends on MMU && CPU_CACHE_NONALIASING
>> +       help
>> +         The address space of Andes processors is only 4 Gigabytes large
>> +         and it has to accommodate user address space, kernel address
>> +         space as well as some memory mapped IO. That means that, if you
>> +         have a large amount of physical memory and/or IO, not all of the
>> +         memory can be "permanently mapped" by the kernel. The physical
>> +         memory that is not permanently mapped is called "high memory".
>> +
>> +         Depending on the selected kernel/user memory split, minimum
>> +         vmalloc space and actual amount of RAM, you may not need this
>> +         option which should result in a slightly faster kernel.
>> +
>> +         If unsure, say N.
>
> Generally speaking, highmem support is a mess, and it's better to avoid it.
>
> I see that the two device tree files you have list 1GB of memory. Do you think
> that is a common configuration for actual products? Do you expect any to
> have more than 1GB (or more than 4GB) in the future, or is that the upper
> end of the scale?
>
> If 1GB is a reasonable upper bound, then you could change the vmsplit
> to give slightly less address space to user space and have 1GB of direct-mapped
> kernel memory plus 256MB of vmalloc space reserved for the kernel,
> and completely avoid highmem.

Thanks.
We do realy use 1GB ram in some products.
We also verify CONFIG_HIGHMEM with LTP too.
It seems fine but I will study vmsplit to see if we should use it.

>> +config MEMORY_START
>> +       hex "Physical memory start address"
>> +       default "0x00000000"
>> +       help
>> +         Physical memory start address, you may modify it if it is porting to
>> +         a new SoC with different start address.
>> +endmenu
>
> On ARM, we found options like this to be rather problematic since it prevents
> you from running the same kernel on boards that are otherwise compatible.
>
> If the architecture easily allows the memory to start at address 0, could
> you require this address for all SoCs that want to run Linux, and get
> rid of the compile-time option?

Thanks.
The reason we need this config is because we need to define PHYS_OFFSET.
#define PHYS_OFFSET     (CONFIG_MEMORY_START)

It needs to be set in compile-time. I don't know how to get rid of it.
