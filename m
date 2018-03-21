From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Date: Wed, 21 Mar 2018 15:36:43 +0800
Message-ID: <CAK8P3a3pat6wQ+9gbf_wtp6+dur_h=Zp1896rogZHnehVnqVNA@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com> <20180320131342.GA31542@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320131342.GA31542@guoren>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 20, 2018 at 9:13 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> Hi arnd,
>
> On Mon, Mar 19, 2018 at 11:45:23PM +0800, Arnd Bergmann wrote:
>> Does your architecture provide a reliable high-reslution clocksource?
>> If yes, you
>> could use that for the delay, rather than a calibrated loop.
> Currently, all boards have clocksource drivers and the reslution is depend on SOC.
> I'll try to remove it.

If the clocksource depends on a driver rather than a feature of the
architecture,
this may not be worth optimizing though, so maybe leave it as it is for now.

>> Usually the kernel should allow multiple CPU types to be selected
>> together, or ask for a "minimum architecture" level to be selected
>> by allow newer cores to be used as a superset.
> No, I need keep them seperate.

Can you explain? What is it that makes them all incompatible?

>> > +config CPU_TLB_SIZE
>> > +       int
>> > +       default "128"   if(CPU_CK610 || CPU_CK807 || CPU_CK810)
>> > +       default "1024"  if(CPU_CK860)
>> > +
>> > +config L1_CACHE_SHIFT
>> > +       int
>> > +       default "4"     if(CPU_CK610)
>> > +       default "5"     if(CPU_CK807 || CPU_CK810)
>> > +       default "6"     if(CPU_CK860)
>>
>> I think you then need to reverse the order of the list here: When e.g. CK860
>> and CK810 are both enabled, L1_CACHE_SHIFT should be the largest
>> possible size.
> No, I use L1_CACHE_SHIFT to determine the size of cache_line.
> When I flush cache for a range of memory, I need the size to loop flush cache line.

This is still relatively easy to fix, you just need a cpu specific loop
that uses the actual line size rather than the maximum size.

>> > +config SSEG0_BASE
>> > +       hex "Direct mapping physical address"
>> > +       default 0x0
>> > +       help
>> > +         There are MSAx regs can be used to change the base physical address
>> > +         of direct mapping. The default base physical address is 0x0.
>> > +
>> > +config RAM_BASE
>> > +       hex "DRAM base address offset from SSEG0_BASE, it must be the same with dts memory."
>> > +       default 0x08000000
>>
>> To allow one kernel to run on multiple boards, it's better to detect
>> these two at runtime.
> CK-CPUs have a mips-like direct-mapping, and I use the macros to calculate the virtual-addr
> in headers.

On many architectures, we detect the offsets at boot time and pass
them as variables. On
ARM, we go as far as patching the kernel at boot time to have constant
offsets, but usually
it's not worth the effort.

>> > +config CSKY_NR_IRQS
>> > +       int "NR_IRQS to max virtual interrupt numbers of the whole system"
>> > +       range 64 8192
>> > +       default "128"
>> > +endmenu
>>
>> This should no longer be needed, with the IRQ domain code, any number
>> of interrupts
>> can be used without noticeable overhead.
> Not I use it, some of our users need it to expand the GPIO irqs. Because
> they don't use irq domain code properly. I move it to Kconfig.debug, OK?

It sounds like your GPIO driver should get fixed to use irq domains right,
it should not be too hard. The number of GPIOs is typically a compile
time constant today, but we also try to turn it into a dynamic allocation
that we have for IRQs on most targets.

>> > +config CSKY_BUILTIN_DTB
>> > +       bool "Use kernel builtin dtb"
>> > +       default n
>> > +
>> > +config CSKY_BUILTIN_DTB_NAME
>> > +       string "kernel builtin dtb name"
>> > +       depends on CSKY_BUILTIN_DTB
>>
>> It's generally better not to use a builtin dtb, but use the bootloader
>> to pass a dtb.
>>
>> If you need to support existing bootloaders, the best way is to allow
>> appending the dtb to the kernel.
> Most of our boards use bootloader to pass the dtb, but Hangzhou
> Nationalchip want dtb compiled in the vmlinux. So I keep it in
> Kconfig.debug.

What I meant here is that you can get the same behavior by
appending the dtb to the kernel rather than linking it into the
kernel. The reason for preferring the appended one is that you
can more easily use the same kernel binary across boards with
different bootloaders.

>> > +ifeq ($(VERSION)_$(PATCHLEVEL), 4_9)
>> > +COMPAT_KERNEL_4_9 = -DCOMPAT_KERNEL_4_9
>> > +endif
>>
>> Should not be needed
> May I keep it? It's a very internal macro for arch/csky and I can
> maintain the linux-4.9 together.

I'd say it's better to get rid of it for the upstream port, more importantly
getting rid of the code that checks for this symbol. Usually what happens
with version checks like this one is that they get out of sync quickly
as a new kernel version does things differently and diverges more
from the old release you were comparing against. In device drivers,
we tend to remove all those checks.

>> -fno-tree-dse?
> This is from "gcc-4.5 compile linux-4.7" and it will cause wrong code without
> -fno-tree-dse for list.h. Now we use gcc-6.3, so I will try to remove it.

You can also use the cc-ifversion Makefile macro to apply it on
the old compiler. That way you can still use gcc-4.5 as long as
that remains relevant but don't get worse code generation on
modern versions.

>> > +++ b/arch/csky/abiv1/Makefile
>> > @@ -0,0 +1,8 @@
>> > +obj-y +=       src/bswapdi.o
>> > +obj-y +=       src/bswapsi.o
>> > +obj-y +=       src/cacheflush.o
>> > +obj-y +=       src/memcpy.o
>> > +obj-y +=       src/mmap.o
>> > +
>> > +obj-$(CONFIG_CPU_NEED_SOFTALIGN) +=    src/alignment.o
>>
>> Better not use subdirectories like that.
> Ok, I will change them like this:
>   obj-y +=      bswapdi.o
>   obj-y +=      bswapsi.o
>   ...
>
>> Can you explain why you need the alignement fixups?
> For abiv1 ck610 couldn't handle the unalignment address access, so we
> need soft-alignment exception to fixup. There is no problem in abiv2 cpus.

Ok. Generally speaking, architectures that don't allow unaligned access
should have all code built in a way that uses aligned access (gcc normally
falls back to byte access when it encounters an unaligned pointer at
compile time), but if this is just for old CPUs that are not used in future
products, having the fixup does sound simpler, as it allows you to still
run new binaries on the old machines. I haven't looked at the implementation
for the fixup here, but I remember the same thing from the nds32 port.
In that case, we ended up keeping the fixup as an option for old
user space, but disabled to softalign fixups for kernel code. Can you do
the same thing here?

         Arnd
