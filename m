From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Date: Tue, 20 Mar 2018 21:13:46 +0800
Message-ID: <20180320131342.GA31542@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi arnd,

On Mon, Mar 19, 2018 at 11:45:23PM +0800, Arnd Bergmann wrote:
> > +       select ARCH_WANT_IPC_PARSE_VERSION
> 
> Drop ipc_parse_version here, it's only for old architectures.
>
I will remove it.

> > +       select HAVE_OPROFILE
> > +       select HAVE_PERF_EVENTS
> 
> Do you still need oprofile when you have perf?
I'll remove HAVE_OPROFILE and arch/csky/oprofile.

> > +       select MODULES_USE_ELF_REL if MODULES
> > +       select MODULES_USE_ELF_RELA if MODULES
> 
> You should only need one of these two.
Yes, I will keep RELA and current csky-gcc only give .rela section.

> > +       select OLD_SIGACTION
> > +       select OLD_SIGSUSPEND3
> 
> These should not be needed.
Ok, remove them.

> > +config CPU_HAS_TLBI
> > +       bool
> > +       default n
> 
> 'default n' is redundant and can be dropped.
Ok

> > +config GENERIC_CALIBRATE_DELAY
> > +       bool
> > +       default y
> 
> Does your architecture provide a reliable high-reslution clocksource?
> If yes, you
> could use that for the delay, rather than a calibrated loop.
Currently, all boards have clocksource drivers and the reslution is depend on SOC.
I'll try to remove it.

> > +       select HIGHMEM
> > +       select CPU_HAS_TLBI
> > +       select CPU_HAS_CACHEV2
> > +endchoice
> 
> Why select 'HIGHMEM' based on the CPU type? You should only need it
> when you have more than 1GB of RAM, and it can be a performance
> problem when it's enabled without need.
OK, I'll give a HIGHMEM option.
 
> Usually the kernel should allow multiple CPU types to be selected
> together, or ask for a "minimum architecture" level to be selected
> by allow newer cores to be used as a superset.
No, I need keep them seperate.

> > +config CPU_TLB_SIZE
> > +       int
> > +       default "128"   if(CPU_CK610 || CPU_CK807 || CPU_CK810)
> > +       default "1024"  if(CPU_CK860)
> > +
> > +config L1_CACHE_SHIFT
> > +       int
> > +       default "4"     if(CPU_CK610)
> > +       default "5"     if(CPU_CK807 || CPU_CK810)
> > +       default "6"     if(CPU_CK860)
> 
> I think you then need to reverse the order of the list here: When e.g. CK860
> and CK810 are both enabled, L1_CACHE_SHIFT should be the largest
> possible size.
No, I use L1_CACHE_SHIFT to determine the size of cache_line.
When I flush cache for a range of memory, I need the size to loop flush cache line.

> > +config SSEG0_BASE
> > +       hex "Direct mapping physical address"
> > +       default 0x0
> > +       help
> > +         There are MSAx regs can be used to change the base physical address
> > +         of direct mapping. The default base physical address is 0x0.
> > +
> > +config RAM_BASE
> > +       hex "DRAM base address offset from SSEG0_BASE, it must be the same with dts memory."
> > +       default 0x08000000
> 
> To allow one kernel to run on multiple boards, it's better to detect
> these two at runtime.
CK-CPUs have a mips-like direct-mapping, and I use the macros to calculate the virtual-addr 
in headers.

> > +config CSKY_NR_IRQS
> > +       int "NR_IRQS to max virtual interrupt numbers of the whole system"
> > +       range 64 8192
> > +       default "128"
> > +endmenu
> 
> This should no longer be needed, with the IRQ domain code, any number
> of interrupts
> can be used without noticeable overhead.
Not I use it, some of our users need it to expand the GPIO irqs. Because
they don't use irq domain code properly. I move it to Kconfig.debug, OK?

> Make it either
> 
>             def_bool y
> 
> or
> 
>            bool
>            default y
OK

> > +config CSKY_BUILTIN_DTB
> > +       bool "Use kernel builtin dtb"
> > +       default n
> > +
> > +config CSKY_BUILTIN_DTB_NAME
> > +       string "kernel builtin dtb name"
> > +       depends on CSKY_BUILTIN_DTB
> 
> It's generally better not to use a builtin dtb, but use the bootloader
> to pass a dtb.
> 
> If you need to support existing bootloaders, the best way is to allow
> appending the dtb to the kernel.
Most of our boards use bootloader to pass the dtb, but Hangzhou
Nationalchip want dtb compiled in the vmlinux. So I keep it in
Kconfig.debug.

> > +ifeq ($(VERSION)_$(PATCHLEVEL), 4_9)
> > +COMPAT_KERNEL_4_9 = -DCOMPAT_KERNEL_4_9
> > +endif
> 
> Should not be needed
May I keep it? It's a very internal macro for arch/csky and I can
maintain the linux-4.9 together.


> > +KBUILD_CFLAGS +=       -ffreestanding \
> 
> -ffreestanding usually results in worse code and should not be needed
OK, remove it.

> > +                       -fno-tree-dse \
> > +                       -pipe \
> > +                       -Wno-uninitialized \
> 
> For -Wno-uninitialized, better fix the bugs properly. Can you explain
> why you want
It will mask some warnings :P, and I will remove it.

> -fno-tree-dse?
This is from "gcc-4.5 compile linux-4.7" and it will cause wrong code without
-fno-tree-dse for list.h. Now we use gcc-6.3, so I will try to remove it.

> > +++ b/arch/csky/abiv1/Makefile
> > @@ -0,0 +1,8 @@
> > +obj-y +=       src/bswapdi.o
> > +obj-y +=       src/bswapsi.o
> > +obj-y +=       src/cacheflush.o
> > +obj-y +=       src/memcpy.o
> > +obj-y +=       src/mmap.o
> > +
> > +obj-$(CONFIG_CPU_NEED_SOFTALIGN) +=    src/alignment.o
> 
> Better not use subdirectories like that.
Ok, I will change them like this:
  obj-y +=	bswapdi.o
  obj-y +=	bswapsi.o
  ...

> Can you explain why you need the alignement fixups?
For abiv1 ck610 couldn't handle the unalignment address access, so we
need soft-alignment exception to fixup. There is no problem in abiv2 cpus.

Best Regards
  Guo Ren
